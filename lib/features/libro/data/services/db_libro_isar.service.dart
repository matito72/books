import 'dart:io';

import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/models/libro_isar_to_save.module.dart';
import 'package:books/resources/bisac_codes.dart';
import 'package:books/resources/item_exception.dart';
import 'package:books/resources/libro_field_selected.dart';
import 'package:books/utilities/ordinamento_libri_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:isar/isar.dart';

class DbLibroIsarService {
  final Directory _appDocumentDir;  
  
  DbLibroIsarService(this._appDocumentDir);

  Future<Isar> _openBoxLibro(String nomeLibreria) async {
    if (Isar.instanceNames.isEmpty || !Isar.instanceNames.contains(nomeLibreria)) {
      if (Isar.getInstance(nomeLibreria) != null && Isar.getInstance(nomeLibreria)!.isOpen) {
        Isar.getInstance(nomeLibreria)!.close();
      }
      return await Isar.open(
        name: nomeLibreria, 
        [LibroIsarModelSchema], 
        directory: _appDocumentDir.path
      );
    }

    return Future.value(Isar.getInstance(nomeLibreria));
  }

  // Future<int> countLibri(String? nomeLibreria) async {
  //   Isar isarLibro = await _openBoxLibro(nomeLibreria ?? ComArea.libreriaInUso!.nome);
  //   int count = await isarLibro.libroIsarModels.count();
  //   await isarLibro.close();

  //   return count;
  // }

  Future<int> countLibriLibreria(LibreriaIsarModel libreriaSel) async {
    Isar isarLibro = await _openBoxLibro(libreriaSel.nome);

    int count = await isarLibro.libroIsarModels.count();
    await isarLibro.close();

    return count;
  }

  Future<List<LibroIsarModel>> readLstLibroFromDb(LibreriaIsarModel libreriaSel) async {
    Isar isarLibro = await _openBoxLibro(libreriaSel.nome);

    List<LibroIsarModel> lstLibroViewSaved = [];

    if (ComArea.booksSearchParameters.isNotEmpty()) {
      lstLibroViewSaved = await isarLibro.libroIsarModels.filter()
        .siglaLibreriaEqualTo(libreriaSel.sigla)
        .optional(
          ComArea.booksSearchParameters.txtTitolo != null && ComArea.booksSearchParameters.txtTitolo!.trim().isNotEmpty,
          (q) => q.titoloMatches('*${ComArea.booksSearchParameters.txtTitolo}*', caseSensitive: false)
        )
        .optional(
          ComArea.booksSearchParameters.txtAutore != null && ComArea.booksSearchParameters.txtAutore!.trim().isNotEmpty,
          (q) => q.lstAutoriElementMatches('*${ComArea.booksSearchParameters.txtAutore}*', caseSensitive: false)
        )
        .optional(
          ComArea.booksSearchParameters.txtEditore != null && ComArea.booksSearchParameters.txtEditore!.trim().isNotEmpty,
          (q) => q.editoreMatches('*${ComArea.booksSearchParameters.txtEditore}*', caseSensitive: false)
        )
        .optional(
          ComArea.booksSearchParameters.txtCategoria != null && ComArea.booksSearchParameters.txtCategoria!.trim().isNotEmpty 
              && ComArea.booksSearchParameters.txtCategoria != BisacList.nonClassifiable,
          (q) => q.lstCategoriaElementContains(ComArea.booksSearchParameters.txtCategoria!, caseSensitive: false)
        )
        .optional(
          ComArea.booksSearchParameters.txtPrezzoMin != null && ComArea.booksSearchParameters.txtPrezzoMin!.trim().isNotEmpty,
          (q) => q.prezzoGreaterThan(Utils.getPositiveDouble(Utils.getTrimUppercaseParameter(ComArea.booksSearchParameters.txtPrezzoMin))),
        )
        .optional(
          ComArea.booksSearchParameters.txtPrezzoMax != null && ComArea.booksSearchParameters.txtPrezzoMax!.trim().isNotEmpty,
          (q) => q.prezzoLessThan(Utils.getPositiveDouble(Utils.getTrimUppercaseParameter(ComArea.booksSearchParameters.txtPrezzoMax))),
        )
        .optional(
          ComArea.booksSearchParameters.txtDescrizione != null && ComArea.booksSearchParameters.txtDescrizione!.trim().isNotEmpty,
          (q) => q.descrizioneMatches('*${ComArea.booksSearchParameters.txtDescrizione}*', caseSensitive: false)
        )
        .findAll();
    } else {
      lstLibroViewSaved = await isarLibro.libroIsarModels.filter()
        .siglaLibreriaEqualTo(libreriaSel.sigla)
        .group(
          (q) => q
          .optional(
            ComArea.bookToSearch.trim().isNotEmpty,
            (q) => q.titoloMatches('*${ComArea.bookToSearch}*', caseSensitive: false)
          )
          .or()
          .optional(
            ComArea.bookToSearch.trim().isNotEmpty,
            (q) => q.lstAutoriElementMatches('*${ComArea.bookToSearch}*', caseSensitive: false)
          )
          .or()
          .optional(
            ComArea.bookToSearch.trim().isNotEmpty,
            (q) => q.editoreMatches('*${ComArea.bookToSearch}*', caseSensitive: false)
          )
          .or()
          .optional(
            ComArea.bookToSearch.trim().isNotEmpty,
            (q) => q.lstCategoriaElementContains(ComArea.bookToSearch, caseSensitive: false)
          )
          .or()
          .optional(
            ComArea.bookToSearch.trim().isNotEmpty && (double.tryParse(ComArea.bookToSearch) != null),
            (q) => q.prezzoEqualTo(double.parse(ComArea.bookToSearch)),
          )
          .or()
          .optional(
            ComArea.bookToSearch.trim().isNotEmpty && (double.tryParse(ComArea.bookToSearch) != null),
            (q) => q.prezzoEqualTo(double.parse(ComArea.bookToSearch)),
          )
          .or()
          .optional(
            ComArea.bookToSearch.trim().isNotEmpty, 
            (q) => q.descrizioneMatches('*${ComArea.bookToSearch}*', caseSensitive: false))
        )
        .findAll();
    }

    await isarLibro.close();

    return lstLibroViewSaved;
  }

  int libroViewModelSort(LibroIsarModel a, LibroIsarModel b, List<LibroFieldSelected> lstOrdinamentoLibri) {
    int ret = 0;
    bool stop = false;

    int i = 0;
    while (!stop && (i < lstOrdinamentoLibri.length)) {
      LibroFieldSelected ordinamentoLibri = lstOrdinamentoLibri[i];
      if (!ordinamentoLibri.isSelected) {
        i++;
        continue;
      }
      ret = OrdinamentoLibriUtils.getLibroViewModelValue(a, ordinamentoLibri).compareTo(OrdinamentoLibriUtils.getLibroViewModelValue(b, ordinamentoLibri));
      if (ret != 0) {
        stop = true;
      } 
      i++;
    }

    return ret;
  }

  Future<LibroIsarModel?> getLibroBySiglaLibreriaAndIsbn(Isar? isarLibro, String nomeLibreria, int siglaLibreria, String isbn) async {
    bool isIsarOpen = true;
    if (isarLibro == null) {
      isIsarOpen = false;
      isarLibro = await _openBoxLibro(nomeLibreria);
    }

    List<LibroIsarModel> lstLibro = await isarLibro.libroIsarModels.filter()
      .isbnEqualTo(isbn, caseSensitive: false)
      .siglaLibreriaEqualTo(siglaLibreria)
      .findAll();

    if (!isIsarOpen) {
      await isarLibro.close();
    }

    if (lstLibro.isNotEmpty && lstLibro.length > 1) {
      throw ItemPresentException(ItemType.libro, "Attenzione: ci sono DUE libri nella stessa libreria '$nomeLibreria' con lo stesso ISBN '$isbn'");
    }

    return lstLibro.isNotEmpty ? lstLibro[0] : null;
  }

  Future<void> saveLibroToDb(LibroIsarToSaveModel libroToSaveMode, bool isNew) async {
    LibroIsarModel libroToNewEdit = libroToSaveMode.libroViewModel;
    int siglaLibreriaOld = libroToSaveMode.siglaLibreriaOld ?? libroToNewEdit.siglaLibreria;

    if (isNew && libroToNewEdit.dataInserimento == Constant.dataDefault) {
      libroToNewEdit.dataInserimento = Utils.getDataNow();
    }
    if (libroToNewEdit.siglaLibreria == 0) {
      libroToNewEdit.siglaLibreria = ComArea.libreriaInUso!.sigla;
    }
    if (libroToNewEdit.isbn.isEmpty) {
      libroToNewEdit.isbn = Utils.getIsbnGenAutoNotNull();
    }
    
    Isar isarLibro = await _openBoxLibro(ComArea.libreriaInUso!.nome);

    LibroIsarModel? libroDbNew = await getLibroBySiglaLibreriaAndIsbn(isarLibro, ComArea.libreriaInUso!.nome, 
      libroToNewEdit.siglaLibreria, libroToNewEdit.isbn
    );
    LibroIsarModel? libroDbOld = await getLibroBySiglaLibreriaAndIsbn(isarLibro, ComArea.libreriaInUso!.nome, 
      siglaLibreriaOld, libroToNewEdit.isbn
    );

    if (isNew && libroDbNew != null) {
      await isarLibro.close();
      throw ItemPresentException(ItemType.libro, 'Libro ${libroToNewEdit.isbn}-${libroToNewEdit.titolo} già presente!');
    } else if (!isNew && libroDbNew == null) {
      await isarLibro.close();
      throw ItemNotPresentException(ItemType.libro, 'Libro ${libroToNewEdit.isbn}-${libroToNewEdit.titolo} non presente!');
    }

    await isarLibro.writeTxn(() async {
      await isarLibro.libroIsarModels.put(libroToNewEdit);
    });

    if (!isNew && siglaLibreriaOld != libroToNewEdit.siglaLibreria && libroDbOld != null) {
      await isarLibro.writeTxn(() async {
        await isarLibro.libroIsarModels.delete(libroDbOld.id);
      });
    }
    
    await isarLibro.close();
  }

  Future<void> deleteLibroToDb(LibroIsarModel libroToDelete) async {
    String nomeLibreria = ComArea.mapCodDescLibreria[libroToDelete.siglaLibreria]!;
    Isar isarLibro = await _openBoxLibro(nomeLibreria);

    LibroIsarModel? libroIsarModel = await getLibroBySiglaLibreriaAndIsbn(isarLibro, nomeLibreria, libroToDelete.siglaLibreria, libroToDelete.isbn);

    if (libroIsarModel == null) {
      await isarLibro.close();
      throw 'Libro ${libroToDelete.isbn}-${libroToDelete.titolo} non presente!';
    }
    
    await isarLibro.writeTxn(() async {
      await isarLibro.libroIsarModels.delete(libroToDelete.id);
    });

    await isarLibro.close();
  }

  Future<int> deleteAllLibri() async {
    int nrRecordDeleted = 0;

    for (LibreriaIsarModel libreriaIsarModel in ComArea.lstLibrerieInUso) {
      nrRecordDeleted += await deleteAllLibriLibreria(libreriaIsarModel);
    }

    return nrRecordDeleted;
  }

  Future<int> deleteAllLibriLibreria(LibreriaIsarModel libreriaModel) async {
    int nrRecordDeleted = 0;
    Isar isarLibro = await _openBoxLibro(libreriaModel.nome);

    List<LibroIsarModel> lstLibro = await isarLibro.libroIsarModels.filter()
      .siglaLibreriaEqualTo(libreriaModel.sigla)
      .findAll();

    final List<int> lstIdLibro = lstLibro.map((libro) => libro.id).toList(growable: false);

    await isarLibro.writeTxn(() async {
      await isarLibro.libroIsarModels.deleteAll(lstIdLibro);
    });

    return nrRecordDeleted;
  }
}
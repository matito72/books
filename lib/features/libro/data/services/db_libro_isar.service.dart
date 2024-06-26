import 'dart:io';

import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
// import 'package:books/features/libro/data/models/libro_isar.module.util.dart';
import 'package:books/features/libro/data/models/link_isar.module.dart';
import 'package:books/features/libro/data/models/pdf_isar.module.dart';
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
        [LibroIsarModelSchema, LinkIsarModuleSchema, PdfIsarModuleSchema], 
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


    // if (lstLibroViewSaved.isNotEmpty) {
    //   for (LibroIsarModel libro in lstLibroViewSaved) {
    //     await libro.links.load();
    //     int nr = await libro.links.count();
    //     if (nr != 0) {
    //       print('----------------> count: ${libro.titolo} - $nr ');
    //       print('----------------> URL = "${libro.links.elementAt(0).url}"');
    //     }
    //   }
    // }
    // final lst = isarLibro.linkIsarModules.where().findAll();

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

  Future<LibroIsarModel?> getLibroById(int id, {int? siglaLibreria, Isar? isarLibro}) async {
    siglaLibreria = (siglaLibreria == null || siglaLibreria == 0) ? ComArea.libreriaInUso!.sigla : siglaLibreria;

    String nomeLibreria = ComArea.mapCodDescLibreria[siglaLibreria]!;
    bool isOpenIsar = false;

    if (isarLibro == null) {
      isOpenIsar = true;
      isarLibro = await _openBoxLibro(nomeLibreria);
    }
    
    LibroIsarModel? libro = await isarLibro.libroIsarModels.filter()
      .siglaLibreriaEqualTo(siglaLibreria)
      .idEqualTo(id)
      .findFirst();

    if (libro != null) {
      libro.lstLinkIsarModule.load();
      libro.lstPdfIsarModule.load();
    }

    if (isOpenIsar) {
      await isarLibro.close();
    }
    
    return libro;
  }

  Future<LibroIsarModel?> getLibroBySiglaLibreriaAndIsbn(int siglaLibreria, String isbn, {Isar? isarLibro}) async {
    String nomeLibreria = ComArea.mapCodDescLibreria[siglaLibreria]!;
    bool isOpenIsar = false;

    if (isarLibro == null) {
      isOpenIsar = true;
      isarLibro = await _openBoxLibro(nomeLibreria);
    }

    List<LibroIsarModel> lstLibro = await isarLibro.libroIsarModels.filter()
      .isbnEqualTo(isbn, caseSensitive: false)
      .siglaLibreriaEqualTo(siglaLibreria)
      .findAll();

    if (isOpenIsar) {
      await isarLibro.close();
    }

    if (lstLibro.isNotEmpty && lstLibro.length > 1) {
      throw ItemPresentException(ItemType.libro, "Attenzione: ci sono DUE libri nella stessa libreria '$nomeLibreria' con lo stesso ISBN '$isbn'");
    }

    return lstLibro.isNotEmpty ? lstLibro[0] : null;
  }

  Future<void> saveLibroToDb(LibroIsarToSaveModel libroToSaveModel, bool isNew) async {
    LibroIsarModel? libroDbOld = await getLibroById(libroToSaveModel.libroViewModel.id, siglaLibreria: libroToSaveModel.siglaLibreriaOld);

    Isar isarLibroNew = await _openBoxLibro(ComArea.libreriaInUso!.nome);

    libroToSaveModel.libroViewModel.siglaLibreria = (libroToSaveModel.libroViewModel.siglaLibreria == 0)
      ? ComArea.libreriaInUso!.sigla
      : libroToSaveModel.libroViewModel.siglaLibreria;

    LibroIsarModel? libroDbNew = await getLibroBySiglaLibreriaAndIsbn(
      libroToSaveModel.libroViewModel.siglaLibreria, 
      libroToSaveModel.libroViewModel.isbn,
      isarLibro: isarLibroNew
    );

    libroToSaveModel.siglaLibreriaOld = (libroToSaveModel.siglaLibreriaOld == null || libroToSaveModel.siglaLibreriaOld == 0) 
      ? libroToSaveModel.libroViewModel.siglaLibreria
      : libroToSaveModel.siglaLibreriaOld;

    if ((libroDbNew != null)
        && (isNew || 
          (libroToSaveModel.siglaLibreriaOld != libroToSaveModel.libroViewModel.siglaLibreria) || (libroToSaveModel.isbnLibroOld != libroToSaveModel.libroViewModel.isbn))) {
      await isarLibroNew.close();
      throw ItemPresentException(ItemType.libro, "Libreria '${ComArea.mapCodDescLibreria[libroToSaveModel.libroViewModel.siglaLibreria]!}':\n libro ${libroToSaveModel.libroViewModel.isbn}-${libroToSaveModel.libroViewModel.titolo} già presente!");  
    } 

    List<LinkIsarModule> lstLinkOld = (libroDbOld != null) ? libroDbOld.lstLinkIsarModule.toList() : [];
    List<PdfIsarModule> lstPdfOld = (libroDbOld != null) ? libroDbOld.lstPdfIsarModule.toList() : [];
    List<int> lstLinkIdToDelete = [];
    List<int> lstPdfIdToDelete = [];

    await isarLibroNew.writeTxn(() async {
      // LINKs
      if (libroToSaveModel.lstLinkIsarModule != null && libroToSaveModel.lstLinkIsarModule!.isNotEmpty) {        
        if (libroDbOld != null) {
          for (LinkIsarModule lk in lstLinkOld) {
            if (libroToSaveModel.lstLinkIsarModule!.toList().map((e) => e.url).contains(lk.url)) {
              libroToSaveModel.lstLinkIsarModule!.removeWhere((e) => e.url == lk.url);
            } else {
              lstLinkIdToDelete.add(lk.id);
            }
          }
          if (lstLinkIdToDelete.isNotEmpty) {
            await isarLibroNew.linkIsarModules.deleteAll(lstLinkIdToDelete);
          }
        }
        await isarLibroNew.linkIsarModules.putAll(libroToSaveModel.lstLinkIsarModule!);
        libroToSaveModel.libroViewModel.lstLinkIsarModule.addAll(libroToSaveModel.lstLinkIsarModule!);
      } else if (lstLinkOld.isNotEmpty) {
         await isarLibroNew.linkIsarModules.deleteAll(lstLinkOld.toList().map((e) => e.id).toList());
      }

      // PDFs
      if (libroToSaveModel.lstPdfIsarModule != null && libroToSaveModel.lstPdfIsarModule!.isNotEmpty) {        
        if (libroDbOld != null) {
          for (PdfIsarModule pdf in lstPdfOld) {
            if (libroToSaveModel.lstPdfIsarModule!.toList().map((e) => e.pathNameFile).contains(pdf.pathNameFile)) {
              libroToSaveModel.lstPdfIsarModule!.removeWhere((e) => e.pathNameFile == pdf.pathNameFile);
            } else {
              lstPdfIdToDelete.add(pdf.id);
            }
          }
          if (lstPdfIdToDelete.isNotEmpty) {
            await isarLibroNew.pdfIsarModules.deleteAll(lstPdfIdToDelete);
          }
        }
        await isarLibroNew.pdfIsarModules.putAll(libroToSaveModel.lstPdfIsarModule!);
        libroToSaveModel.libroViewModel.lstPdfIsarModule.addAll(libroToSaveModel.lstPdfIsarModule!);      
      } else if (lstPdfOld.isNotEmpty) {
         await isarLibroNew.pdfIsarModules.deleteAll(lstPdfOld.toList().map((e) => e.id).toList());
      }
      
      await isarLibroNew.libroIsarModels.put(libroToSaveModel.libroViewModel);

      if (libroToSaveModel.lstLinkIsarModule != null && libroToSaveModel.lstLinkIsarModule!.isNotEmpty) {
        libroToSaveModel.libroViewModel.lstLinkIsarModule.save();
      }

      if (libroToSaveModel.lstPdfIsarModule != null && libroToSaveModel.lstPdfIsarModule!.isNotEmpty) {
        libroToSaveModel.libroViewModel.lstPdfIsarModule.save();
      }
    });


    await isarLibroNew.close();

    if (libroToSaveModel.siglaLibreriaOld != libroToSaveModel.libroViewModel.siglaLibreria) {
      Isar isarLibroOld = await _openBoxLibro(ComArea.mapCodDescLibreria[libroToSaveModel.siglaLibreriaOld]!);
      LibroIsarModel? libroDbOld;

      await isarLibroOld.writeTxn(() async {
        libroDbOld = await getLibroBySiglaLibreriaAndIsbn(
          libroToSaveModel.siglaLibreriaOld!, 
          libroToSaveModel.libroViewModel.isbn,
          isarLibro: isarLibroOld
        );
      });
      if (libroDbOld == null) {
        await isarLibroOld.close();
        throw ItemPresentException(ItemType.libro, "Il libro '${libroToSaveModel.libroViewModel.isbn}' oggetto della modifica non esiste più!");
      }
      await isarLibroOld.writeTxn(() async {
        await isarLibroOld.libroIsarModels.delete(libroDbOld!.id);
      });
      await isarLibroOld.close();
    }
  }

  Future<void> deleteLibroToDb(LibroIsarModel libroToDelete) async {
    String nomeLibreria = ComArea.mapCodDescLibreria[libroToDelete.siglaLibreria]!;
    Isar isarLibro = await _openBoxLibro(nomeLibreria);

    LibroIsarModel? libroIsarModel = await getLibroBySiglaLibreriaAndIsbn(libroToDelete.siglaLibreria, libroToDelete.isbn, isarLibro: isarLibro);

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
import 'dart:io';

import 'package:book/config/com_area.dart';
import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/link_isar.module.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/models/libro_isar_to_save.module.dart';
import 'package:book/resources/bisac_codes.dart';
import 'package:book/resources/item_exception.dart';
import 'package:book/resources/libro_field_selected.dart';
import 'package:book/utilities/ordinamento_libri_utils.dart';
import 'package:book/utilities/utils.dart';
import 'package:isar_community/isar.dart';
import 'package:uuid/uuid.dart';

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

  Future<int> countLibriLibreria(LibreriaIsarModel libreriaSel) async {
    Isar isarLibro = await _openBoxLibro(libreriaSel.nome);

    int count = await isarLibro.libroIsarModels.count();
    await isarLibro.close();

    return count;
  }

  Future<List<LibroIsarModel>> readLstLibroFromDb(LibreriaIsarModel libreriaSel, bool isLoadLinkAndPdf) async {
    Isar isarLibro = await _openBoxLibro(libreriaSel.nome);

    List<LibroIsarModel> lstLibroViewSaved = [];

    if (ComArea.booksSearchParameters.isNotEmpty()) {
      lstLibroViewSaved = await ricercaAvanzata(lstLibroViewSaved, isarLibro, libreriaSel);

      if (ComArea.bookToSearch.trim().isNotEmpty) {
        lstLibroViewSaved = await ricercaSemplice(lstLibroViewSaved, isarLibro, libreriaSel);
      }
    } else {
      lstLibroViewSaved = await ricercaSemplice(lstLibroViewSaved, isarLibro, libreriaSel);
    }

    if (lstLibroViewSaved.isNotEmpty && isLoadLinkAndPdf) {
      for (LibroIsarModel libro in lstLibroViewSaved) {
        libro.lstLinkIsarModule.load();
        libro.lstPdfIsarModule.load();
      }
    }

    await isarLibro.close();
    return lstLibroViewSaved;
  }

  Future<List<LibroIsarModel>> ricercaSemplice(List<LibroIsarModel> lstLibroViewSaved, Isar isarLibro, LibreriaIsarModel libreriaSel) async {
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
    return lstLibroViewSaved;
  }

  Future<List<LibroIsarModel>> ricercaAvanzata(List<LibroIsarModel> lstLibroViewSaved, Isar isarLibro, LibreriaIsarModel libreriaSel) async {
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
    final String nomeLibreria = ComArea.mapCodDescLibreria[siglaLibreria]!;
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

  Future<void> cambiaLibreriaLibroToDb(LibroIsarToSaveModel libroIsarViewModel) async {
    LibroIsarModel libroViewModel = libroIsarViewModel.libroViewModel;

    // Nome Libreria New
    int? siglaLibreriaNew = (libroViewModel.siglaLibreria == 0) ? ComArea.libreriaInUso!.sigla : libroViewModel.siglaLibreria;
    String nomeLibreriaNew = ComArea.mapCodDescLibreria[siglaLibreriaNew]!;

    // 1. Recupera il libro vecchio
    LibroIsarModel? libroDbOld = await getLibroById(libroViewModel.id, siglaLibreria: libroIsarViewModel.siglaLibreriaOld);
    if (libroDbOld == null) {
      throw ItemPresentException(ItemType.libro, "Il libro '${libroViewModel.isbn}' non si trova più!");
    }

    // Libro NEW
    Isar isarLibroNewTmp = await _openBoxLibro(nomeLibreriaNew);
    LibroIsarModel? libroDbNew = await getLibroBySiglaLibreriaAndIsbn(
        libroViewModel.siglaLibreria,
        libroViewModel.isbn,
        isarLibro: isarLibroNewTmp
    );
    await isarLibroNewTmp.close();

    if (libroDbNew != null && libroDbOld.isbn == libroDbNew.isbn) {
      throw ItemPresentException(ItemType.libro, "Il libro '[${libroViewModel.isbn}] - ${libroViewModel.titolo}' è già presente nella libreria '$nomeLibreriaNew'!");
    }

    // Clona il LIBRO
    LibroIsarModel libroNew = libroDbOld.clonaLibro();
    libroNew.siglaLibreria = libroViewModel.siglaLibreria;

    // Lista temporanea per i cloni, poiché lstLinkIsarModule è final e lo popoleremo dopo
    // oppure usiamo direttamente l'IsarLinks come segue:

    // 2. Clona e aggiungi tutti i LINK al nuovo IsarLinks
    List<LinkIsarModule> linksToSave = [];
    if (libroDbOld.lstLinkIsarModule.isNotEmpty) {
      for (final link in libroDbOld.lstLinkIsarModule) {
        final clonedLink = link.clonaLink();
        linksToSave.add(clonedLink);
        // NON aggiungerlo ancora all'IsarLink, perché non ha ancora un ID nel DB
      }
    }

    // 3. Clona e aggiungi tutti i PDF al nuovo IsarLinks
    List<PdfIsarModule> pdfsToSave = [];
    if (libroDbOld.lstPdfIsarModule.isNotEmpty) {
      for (final pdf in libroDbOld.lstPdfIsarModule) {
        final clonedPdf = pdf.clonaPdf();
        pdfsToSave.add(clonedPdf);
        // NON aggiungerlo ancora all'IsarLink, perché non ha ancora un ID nel DB
      }
    }

    // 4. Apri la nuova box Isar
    Isar isarLibroNew = await _openBoxLibro(ComArea.mapCodDescLibreria[libroNew.siglaLibreria]!);

    // Esegui la transazione di scrittura
    await isarLibroNew.writeTxn(() async {

      // 5. Salva prima gli oggetti correlati (Link e PDF)
      // Questo assegna un nuovo ID Isar a ciascun Link e PDF nel nuovo store.
      if (linksToSave.isNotEmpty) {
        // Isar putAll è più efficiente
        await isarLibroNew.linkIsarModules.putAll(linksToSave);
        // Aggiungi gli oggetti ora salvati (con ID valido) all'IsarLinks del nuovo libro
        libroNew.lstLinkIsarModule.addAll(linksToSave);
      }

      if (pdfsToSave.isNotEmpty) {
        await isarLibroNew.pdfIsarModules.putAll(pdfsToSave);
        // Aggiungi gli oggetti ora salvati (con ID valido) all'IsarLinks del nuovo libro
        libroNew.lstPdfIsarModule.addAll(pdfsToSave);
      }

      // 6. Salva il LIBRO
      // Questo assegna un nuovo ID al libro.
      // L'ID del libro è necessario per il passo successivo.
      await isarLibroNew.libroIsarModels.put(libroNew);

      // 7. Salva esplicitamente le relazioni IsarLinks
      // Questo è il passo cruciale per rendere permanente la relazione nel DB.
      if (linksToSave.isNotEmpty) {
        await libroNew.lstLinkIsarModule.save();
      }
      if (pdfsToSave.isNotEmpty) {
        await libroNew.lstPdfIsarModule.save();
      }
    });

    isarLibroNew.close();

    await deleteLibroToDb(libroDbOld);
  }

  Future<void> saveLibroToDb(LibroIsarToSaveModel libroToSaveModel, bool isNew) async {
    if (libroToSaveModel.libroViewModel.isbn.isEmpty) {
      libroToSaveModel.libroViewModel.isbn = generateShortUuid13();
    }

    // Init Input:
    libroToSaveModel.siglaLibreriaOld = (libroToSaveModel.siglaLibreriaOld == null || libroToSaveModel.siglaLibreriaOld == 0)
        ? libroToSaveModel.libroViewModel.siglaLibreria
        : libroToSaveModel.siglaLibreriaOld;
    libroToSaveModel.libroViewModel.siglaLibreria = (libroToSaveModel.libroViewModel.siglaLibreria == 0)
        ? ComArea.libreriaInUso!.sigla
        : libroToSaveModel.libroViewModel.siglaLibreria;

    // Libro OLD: apre-chiude la connessione sulla libreria (che puo' essere diversa dall'attuale) libroToSaveModel.siglaLibreriaOld
    LibroIsarModel? libroDbOld = await getLibroById(libroToSaveModel.libroViewModel.id, siglaLibreria: libroToSaveModel.siglaLibreriaOld);

    int? siglaLibreriaToSave = (libroToSaveModel.libroViewModel.siglaLibreria == 0) ? ComArea.libreriaInUso!.sigla : libroToSaveModel.libroViewModel.siglaLibreria;
    String nomeLibreriaToSave = ComArea.mapCodDescLibreria[siglaLibreriaToSave]!;
    Isar isarLibroNew = await _openBoxLibro(nomeLibreriaToSave);

    // Libro NEW
    LibroIsarModel? libroDbNew = await getLibroBySiglaLibreriaAndIsbn(
        libroToSaveModel.libroViewModel.siglaLibreria,
        libroToSaveModel.libroViewModel.isbn,
        isarLibro: isarLibroNew
    );

    if (libroDbOld == null && libroDbNew == null) {
      // NEW
      await isarLibroNew.writeTxn(() async {
        await saveLibroWithInsertLinkAndPdf(libroToSaveModel, isarLibroNew);
      });
    }
    else if (libroDbOld != null) {
      // UPDATE
      if (libroDbNew != null) {
        int? siglaLibreriaNew = (libroDbNew.siglaLibreria == 0) ? ComArea.libreriaInUso!.sigla : libroDbNew.siglaLibreria;
        // int? siglaLibreriaNew = (libroDbNew == null || libroDbNew.siglaLibreria == 0) ? libroToSaveModel.libroViewModel.siglaLibreria : libroDbNew.siglaLibreria;
        String nomeLibreriaNew = ComArea.mapCodDescLibreria[siglaLibreriaNew]!;
        if (libroToSaveModel.siglaLibreriaOld != libroToSaveModel.libroViewModel.siglaLibreria && libroDbOld.isbn == libroToSaveModel.libroViewModel.isbn) {
          throw ItemPresentException(ItemType.libro, "Il libro '[${libroToSaveModel.libroViewModel.isbn}] - ${libroToSaveModel.libroViewModel.titolo}' è già presente nella libreria '$nomeLibreriaNew'!");
        }
      }

      await isarLibroNew.writeTxn(() async {
        if (libroToSaveModel.libroViewModel.lstLinkIsarModule.isNotEmpty) {
          List<int> lstLinkId = libroToSaveModel.libroViewModel.lstLinkIsarModule.map((e) => e.id).toList();
          await isarLibroNew.linkIsarModules.deleteAll(lstLinkId);
        }
        if (libroToSaveModel.libroViewModel.lstPdfIsarModule.isNotEmpty) {
          List<int> lstPdfId = libroToSaveModel.libroViewModel.lstPdfIsarModule.map((e) => e.id).toList();
          await isarLibroNew.linkIsarModules.deleteAll(lstPdfId);
        }

        await saveLibroWithInsertLinkAndPdf(libroToSaveModel, isarLibroNew);
      });
    }
    await isarLibroNew.close();

    if (libroDbOld != null && libroDbNew == null && libroDbOld.siglaLibreria != siglaLibreriaToSave) {
      await deleteLibroToDb(libroDbOld);
    }
  }

  Future<void> saveLibroWithInsertLinkAndPdf(LibroIsarToSaveModel libroToSaveModel, Isar isarLibroNew) async {
    if (libroToSaveModel.lstLinkIsarModule != null && libroToSaveModel.lstLinkIsarModule!.isNotEmpty) {
      await isarLibroNew.linkIsarModules.putAll(libroToSaveModel.lstLinkIsarModule!);
      // Aggiungi gli oggetti ora salvati (con ID valido) all'IsarLinks del nuovo libro
      libroToSaveModel.libroViewModel.lstLinkIsarModule.addAll(libroToSaveModel.lstLinkIsarModule!);
    }
    
    if (libroToSaveModel.lstPdfIsarModule != null && libroToSaveModel.lstPdfIsarModule!.isNotEmpty) {
      await isarLibroNew.pdfIsarModules.putAll(libroToSaveModel.lstPdfIsarModule!);
      // Aggiungi gli oggetti ora salvati (con ID valido) all'IsarLinks del nuovo libro
      libroToSaveModel.libroViewModel.lstPdfIsarModule.addAll(libroToSaveModel.lstPdfIsarModule!);
    }
    
    // INSERT NEW LIBRO:
    await isarLibroNew.libroIsarModels.put(libroToSaveModel.libroViewModel);
    
    if (libroToSaveModel.lstLinkIsarModule != null && libroToSaveModel.lstLinkIsarModule!.isNotEmpty) {
      await libroToSaveModel.libroViewModel.lstLinkIsarModule.save();
    }
    if (libroToSaveModel.lstPdfIsarModule != null && libroToSaveModel.lstPdfIsarModule!.isNotEmpty) {
      await libroToSaveModel.libroViewModel.lstPdfIsarModule.save();
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

    await isarLibro.txn(() async {
      await libroIsarModel.lstLinkIsarModule.load();
      await libroIsarModel.lstPdfIsarModule.load();
    });

    // 2. Estrai gli ID (operazione Dart veloce)
    final linkIds = libroIsarModel.lstLinkIsarModule.map((l) => l.id).toList();
    final pdfIds = libroIsarModel.lstPdfIsarModule.map((p) => p.id).toList();

    await isarLibro.writeTxn(() async {
      // 1. Elimina tutti gli oggetti collegati in lstLinkIsarModule
      await isarLibro.linkIsarModules.deleteAll(linkIds);

      // 2. Elimina tutti gli oggetti collegati in lstPdfIsarModule
      await isarLibro.pdfIsarModules.deleteAll(pdfIds);

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

    List<int> linkIdsTot = [];
    List<int> pdfIdsTot = [];

    await isarLibro.txn(() async {
      for(LibroIsarModel libro in lstLibro) {
        await libro.lstLinkIsarModule.load();
        await libro.lstPdfIsarModule.load();

        linkIdsTot.addAll(libro.lstLinkIsarModule.map((l) => l.id).toList());
        pdfIdsTot.addAll(libro.lstPdfIsarModule.map((p) => p.id).toList());
      }
    });

    final List<int> lstIdLibro = lstLibro.map((libro) => libro.id).toList(growable: false);

    await isarLibro.writeTxn(() async {
      await isarLibro.linkIsarModules.deleteAll(linkIdsTot);
      await isarLibro.pdfIsarModules.deleteAll(pdfIdsTot);
      await isarLibro.libroIsarModels.deleteAll(lstIdLibro);
    });

    return nrRecordDeleted;
  }

  String generateShortUuid13() {
    var uuid = Uuid();
    String fullUuid = uuid.v4(); // UUID standard, 36 caratteri
    // Prendi i primi 13 caratteri senza trattini
    return fullUuid.replaceAll('-', '').substring(0, 13);
  }
}
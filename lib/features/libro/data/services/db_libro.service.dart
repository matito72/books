import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/features/libro/data/services/filtro_util.dart';
import 'package:books/models/libro_to_save.module.dart';
import 'package:books/resources/bisac_codes.dart';
import 'package:books/resources/item_exception.dart';
import 'package:books/resources/libro_field_selected.dart';
import 'package:books/utilities/ordinamento_libri_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class DbLibroService {
  
  DbLibroService();

  Future<bool> init() async {
    Hive.registerAdapter(LibroViewModelAdapter());

    debugPrint('_boxLibroView - INIZIALIZZATO !!');
    return true;
  }

  bool isServiceInitialized() {
    // return _boxLibroView != null && _boxLibroView!.isOpen;
    return Hive.isAdapterRegistered(LibroViewModelAdapter().typeId);
  }

  Future<Box<LibroViewModel>> _openBoxLibroView() async {
     return await Hive.openBox<LibroViewModel>('boxLibroView');
  }

  Future<void> dispose() async {
    debugPrint('DISPOSE - ....');
    
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();
    await boxLibroView.compact();
    await boxLibroView.close();
    await Hive.close();

    debugPrint('DISPOSE - stop');
  }

  // Future<LibroViewModel?> getLibroFromDb(String key) async {
  //   Box<LibroViewModel> boxLibroView = await _openBoxLibroView();
  //   final LibroViewModel? item = boxLibroView.get(key);
  //   await boxLibroView.close();
  //   return item; 
  // }

  Future<int> countLibri() async {
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();
    int count = boxLibroView.keys.length;
    await boxLibroView.close();

    return count;
  }

  Future<int> countLibriLibreria(LibreriaModel libreriaSel) async {
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();

    List<LibroViewModel> lstLibroViewSaved = boxLibroView.keys.map((key) {
      final item = boxLibroView.get(key);

      return LibroViewModel(
        item!.siglaLibreria,
        item.dataInserimento,
        item.dataUltimaModifica,
        note: item.note,
        isbn: item.isbn,
        googleBookId: item.googleBookId,
        titolo: item.titolo,
        lstAutori: item.lstAutori,
        editore: item.editore,
        descrizione: item.descrizione,
        immagineCopertina: item.immagineCopertina,
        dataPubblicazione: item.dataPubblicazione,
        nrPagine: item.nrPagine,
        lstCategoria: item.lstCategoria.isEmpty ? [BisacList.nonClassifiable] : item.lstCategoria,
        previewLink: item.previewLink,
        isEbook: item.isEbook,
        country: item.country,
        valuta: item.valuta,
        prezzo: item.prezzo,
        stars: item.stars,
        pathImmagineCopertina: item.pathImmagineCopertina
      );
    })
    .where(
      (libroViewModel) => libroViewModel.siglaLibreria == libreriaSel.sigla
    )
    .toList();

    int count = lstLibroViewSaved.length;
    await boxLibroView.close();

    return count;
  }

  Future<List<LibroViewModel>> readLstLibroFromDb(LibreriaModel libreriaSel) async {
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();

    List<LibroViewModel> lstLibroViewSaved = boxLibroView.keys.map((key) {
      final item = boxLibroView.get(key);

      return LibroViewModel(
        item!.siglaLibreria,
        item.dataInserimento,
        item.dataUltimaModifica,
        note: item.note,
        isbn: item.isbn,
        googleBookId: item.googleBookId,
        titolo: item.titolo,
        lstAutori: item.lstAutori,
        editore: item.editore,
        descrizione: item.descrizione,
        immagineCopertina: item.immagineCopertina,
        dataPubblicazione: item.dataPubblicazione,
        nrPagine: item.nrPagine,
        lstCategoria: item.lstCategoria.isEmpty ? [BisacList.nonClassifiable] : item.lstCategoria,
        previewLink: item.previewLink,
        isEbook: item.isEbook,
        country: item.country,
        valuta: item.valuta,
        prezzo: item.prezzo,
        stars: item.stars,
        pathImmagineCopertina: item.pathImmagineCopertina
      );
    })
    .where(
      (libroViewModel) {
        FiltroUtil filtroUtil = FiltroUtil(libroViewModel, libreriaSel);
        return filtroUtil.filtroAvanzato() && filtroUtil.filtroSemplice();
      }
    )
    .toList();
      
    // // ORDER BY
    // List<OrdinamentoLibri> lstOrdinamentoLibri = ComArea.lstBookOrderBy;
    // lstLibroViewSaved.sort((a, b) => libroViewModelSort(a, b, lstOrdinamentoLibri));

    // // ASC - DESC
    // if (!ComArea.orderByAsc) {
    //   lstLibroViewSaved = lstLibroViewSaved.reversed.toList();
    // }

    await boxLibroView.close();
    return lstLibroViewSaved;
  }

  int libroViewModelSort(LibroViewModel a, LibroViewModel b, List<LibroFieldSelected> lstOrdinamentoLibri) {
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

  Future<void> saveLibroToDb(LibroToSaveModel libroToSaveMode, bool isNew) async {
    LibroViewModel libroToNewEdit = libroToSaveMode.libroViewModel;
    String siglaLibreriaOld = libroToSaveMode.siglaLibreriaOld ?? libroToNewEdit.siglaLibreria;

    if (isNew && libroToNewEdit.dataInserimento == Constant.dataDefault) {
      libroToNewEdit.dataInserimento = Utils.getDataNow();
    }
    if (libroToNewEdit.siglaLibreria.isEmpty) {
      libroToNewEdit.siglaLibreria = ComArea.libreriaInUso!.sigla;
    }
    if (libroToNewEdit.isbn.isEmpty) {
      libroToNewEdit.isbn = Utils.getIsbnGenAutoNotNull();
    }
    String newKeyLibro = libroToNewEdit.siglaLibreria + libroToNewEdit.isbn;
    String oldKeyLibro = siglaLibreriaOld + libroToNewEdit.isbn;
    
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();
    LibroViewModel? libroViewModel = boxLibroView.get(isNew ? newKeyLibro : oldKeyLibro);

    if (isNew && libroViewModel != null) {
      await boxLibroView.close();
      throw ItemPresentException(ItemType.libro, 'Libro ${libroToNewEdit.isbn}-${libroToNewEdit.titolo} già presente!');
    } else if (!isNew && libroViewModel == null) {
      await boxLibroView.close();
      throw ItemNotPresentException(ItemType.libro, 'Libro ${libroToNewEdit.isbn}-${libroToNewEdit.titolo} non presente!');
    }
    
    await boxLibroView.put(newKeyLibro, libroToNewEdit.clonaLibro());

    if (!isNew && siglaLibreriaOld != libroToNewEdit.siglaLibreria) {
      await boxLibroView.delete(oldKeyLibro);
    }

    await boxLibroView.close();
  }

  Future<void> deleteLibroToDb(LibroViewModel libroToDelete) async {
    String keyLibro = libroToDelete.siglaLibreria + libroToDelete.isbn;

    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();
    
    LibroViewModel? libroViewModel = boxLibroView.get(keyLibro);
    if (libroViewModel == null) {
      await boxLibroView.close();
      throw 'Libro ${libroToDelete.isbn}-${libroToDelete.titolo} non presente!';
    }
    
    await boxLibroView.delete(keyLibro);
    await boxLibroView.close();
  }

  Future<int> deleteAllLibri() async {
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();

    int nrRecordDeleted = await boxLibroView.clear();
    await boxLibroView.compact();
    await boxLibroView.close();

    return nrRecordDeleted;
  }

  Future<int> deleteAllLibriLibreria(LibreriaModel libreriaModel) async {
    int nrRecordDeleted = 0;
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();

    Iterator<LibroViewModel> it = boxLibroView.values.where((lv) => lv.siglaLibreria.toLowerCase().contains(libreriaModel.sigla.toLowerCase())).toList().iterator;
    while (it.moveNext()) {
      await it.current.delete();
    }
    await boxLibroView.compact();
    await boxLibroView.close();

    return nrRecordDeleted;
  }
}
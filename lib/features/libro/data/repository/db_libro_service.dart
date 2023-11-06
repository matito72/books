import 'package:books/config/constant.dart';
import 'package:books/features/libreria/data/models/libreria_model.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/resources/item_exception.dart';
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

  Future<List<LibroViewModel>> readLstLibroFromDb(LibreriaModel libreriaSel, [String? querySearch]) async {
    List<LibroViewModel> lstLibroViewSaved = [];
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();

    lstLibroViewSaved.addAll(boxLibroView.keys.map((key) {
      final item = boxLibroView.get(key);

      return LibroViewModel(item!.siglaLibreria,
              isbn: item.isbn,
              googleBookId: item.googleBookId,
              titolo: item.titolo,
              lstAutori: item.lstAutori,
              editore: item.editore,
              descrizione: item.descrizione,
              immagineCopertina: item.immagineCopertina,
              dataPubblicazione: item.dataPubblicazione,
              nrPagine: item.nrPagine,
              lstCategoria: item.lstCategoria,
              previewLink: item.previewLink,
              isEbook: item.isEbook,
              country: item.country,
              valuta: item.valuta,
              prezzo: item.prezzo,
              stars: item.stars,
              pathImmagineCopertina: item.pathImmagineCopertina);
    })
    .where(
      (libroViewModel) => libroViewModel.siglaLibreria == libreriaSel.sigla
    )
    .toList());

    await boxLibroView.close();

    return lstLibroViewSaved;
  }

  Future<void> saveLibroToDb(LibroViewModel libroToNewEdit, bool isNew) async {
    libroToNewEdit.siglaLibreria = Constant.libreriaInUso!.sigla;
    String keyLibro = Constant.libreriaInUso!.sigla + libroToNewEdit.isbn;
    
    Box<LibroViewModel> boxLibroView = await _openBoxLibroView();
    LibroViewModel? libroViewModel = boxLibroView.get(keyLibro);

    if (isNew && libroViewModel != null) {
      await boxLibroView.close();
      throw ItemPresentException(ItemType.libro, 'Libro ${libroToNewEdit.isbn}-${libroToNewEdit.titolo} già presente!');
    } else if (!isNew && libroViewModel == null) {
      await boxLibroView.close();
      throw ItemNotPresentException(ItemType.libro, 'Libro ${libroToNewEdit.isbn}-${libroToNewEdit.titolo} non presente!');
    }
    
    await boxLibroView.put(keyLibro, libroToNewEdit);
    await boxLibroView.close();
  }

  Future<void> deleteLibroToDb(LibroViewModel libroToDelete) async {
    String keyLibro = Constant.libreriaInUso!.sigla + libroToDelete.isbn;

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
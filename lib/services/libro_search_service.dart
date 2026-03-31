import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/models/parameter_google_search.module.dart';
import 'package:book/services/goole_apis_books_service.dart';
import 'package:book/widgets/dettaglio_libro/barcode_scanner_screen.dart';
import 'package:flutter/material.dart';

// import '../config/constant.dart';
import 'open_library_service.dart';
// import '../widgets/dettaglio_libro/barcode_scanner_screen.dart';

class LibroSearchService {

  static Future<String> scanBarcodeNormal(BuildContext context) async {
    // Aggiungi 'BuildContext context' come parametro per poter navigare

    // Avvia la schermata di scansione e attende che venga completata
    final String? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BarcodeScannerScreen(),
      ),
    );

    // Se il risultato è nullo (es. l'utente ha premuto indietro), restituisce una stringa vuota o un messaggio di errore.
    return result ?? '-1';
  }

  
  static Future<List<LibroIsarModel>> searchBooksByBarcode(String isbn) async {
    // List<LibroIsarModel> ret = await simpleGoogleBooksSearch(ParameterGoogleSearchModel(isbn: isbn));
    // if (ret.isEmpty) {
    //   ret = await simpleOpenLibraryBooksSearch(ParameterGoogleSearchModel(isbn: isbn));
    // }
    return simpleBooksSearch(ParameterGoogleSearchModel(isbn: isbn), 0, true);
  }

  static Future<List<LibroIsarModel>> _simpleGoogleBooksSearch(ParameterGoogleSearchModel googleSearchModel, int offset, bool isWithApiKey) async {
    return (googleSearchModel.title != null ||
            googleSearchModel.author != null ||
            (googleSearchModel.isbn != null && googleSearchModel.isbn != "-1"))
        ? await GooleApisBooksService.getLibri(googleSearchModel, offset, isWithApiKey)
        : [];
  }

  static Future<List<LibroIsarModel>> _simpleOpenLibraryBooksSearch(ParameterGoogleSearchModel googleSearchModel, int offset) async {
    return (googleSearchModel.title != null ||
        googleSearchModel.author != null ||
        (googleSearchModel.isbn != null && googleSearchModel.isbn != "-1"))
        ? await OpenLibraryService.getLibri(googleSearchModel, offset)
        : [];
  }

  static Future<List<LibroIsarModel>> simpleBooksSearch(ParameterGoogleSearchModel query, int offset, bool isSearchAll) async {
    // 1. Prova con Google Books
    List<LibroIsarModel> risultatiGoogle = await _simpleGoogleBooksSearch(query, offset, false);
    List<LibroIsarModel> risultatiTotale = [];

    if (risultatiTotale.isEmpty) {
      risultatiTotale.addAll(await _simpleGoogleBooksSearch(query, offset, true));
    } else {
      risultatiTotale.addAll(risultatiGoogle);
    }
    if (risultatiTotale.isEmpty || isSearchAll) {
      risultatiTotale.addAll(await _simpleOpenLibraryBooksSearch(query, offset));
    }

    return risultatiTotale;
  }
}




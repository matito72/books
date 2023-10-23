// import 'package:books/features/libro/data/models/libro_search_model.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/models/parameter_google_search_model.dart';
import 'package:books/services/goole_apis_books_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

/// 9788804680604 : Il problema dei tre corpi
/// 
class LibroSearchService {

  static Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Impossibile ottenere la versione della piattaforma software/hardware.';
    }
    
    return barcodeScanRes;
  }

  static Future<List<LibroViewModel>> searchBooksByBarcode(String isbn) async {
    return await simpleGoogleBooksSearch(ParameterGoogleSearchModel(isbn: isbn));

    // return lstResult.isNotEmpty 
    //   ? DataSuccess(data: lstResult)
    //   : DataFailed("Nessun libro trovato con ISBN: $isbn", ActDataResult.notFound);
  }

  static Future<List<LibroViewModel>> simpleGoogleBooksSearch(ParameterGoogleSearchModel googleSearchModel) async {
    final GooleApisBooksService gooleApisBooksService = GooleApisBooksService();
    
    return (googleSearchModel.title != null || googleSearchModel.author != null || googleSearchModel.isbn != null)
      ? await gooleApisBooksService.cercaLibri(googleSearchModel, 0)
      : [];
  }

}
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/models/parameter_google_search.module.dart';
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

  static Future<List<LibroIsarModel>> searchBooksByBarcode(String isbn) async {
    return await simpleGoogleBooksSearch(ParameterGoogleSearchModel(isbn: isbn));

    // return lstResult.isNotEmpty 
    //   ? DataSuccess(data: lstResult)
    //   : DataFailed("Nessun libro trovato con ISBN: $isbn", ActDataResult.notFound);
  }

  static Future<List<LibroIsarModel>> simpleGoogleBooksSearch(ParameterGoogleSearchModel googleSearchModel) async {
    return (googleSearchModel.title != null || googleSearchModel.author != null || (googleSearchModel.isbn != null && googleSearchModel.isbn != "-1"))
      ? await GooleApisBooksService.getLibri(googleSearchModel, 0, -1)
      : [];
  }

}
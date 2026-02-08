import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/models/parameter_google_search.module.dart';
import 'package:book/services/goole_apis_books_service.dart';
import 'package:book/widgets/dettaglio_libro/barcode_scanner_screen.dart';
import 'package:flutter/material.dart';
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

  // static Future<String> scanBarcodeNormal(BuildContext context) async {
  //   // Avvia la schermata di scansione e attende che venga completata
  //   return await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => MobileScanner(
  //         // Configura la fotocamera per rilevare solo i codici a barre, se necessario
  //         // Se omesso, rileva tutti i tipi supportati (QR, Barcode, etc.)
  //         // Ad esempio, per solo i codici 1D (EAN, UPC, etc.):
  //         // formats: const [BarcodeFormat.ean13, BarcodeFormat.upcA],
  //
  //         onDetect: (capture) {
  //           final List<Barcode> barcodes = capture.barcodes;
  //           if (barcodes.isNotEmpty) {
  //             final String? barcodeValue = barcodes.first.rawValue;
  //
  //             // Se un valore viene rilevato, chiude la schermata e restituisce il valore.
  //             if (barcodeValue != null) {
  //               Navigator.of(context).pop(barcodeValue);
  //             }
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  // static Future<String> scanBarcodeNormal(BuildContext context) async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => MobileScanner(
  //
  //           onDetect: (capture) {
  //             final List<Barcode> barcodes = capture.barcodes;
  //             if (barcodes.isNotEmpty) {
  //               final String? barcodeValue = barcodes.first.rawValue;
  //
  //               // Se un valore viene rilevato, chiude la schermata e restituisce il valore.
  //               if (barcodeValue != null) {
  //                 Navigator.of(context).pop(barcodeValue);
  //               }
  //             }
  //           },
  //         ),
  //       ),
  //     );
  //   } on Exception {
  //     barcodeScanRes = 'Impossibile ottenere la versione della piattaforma software/hardware.';
  //   }
  //
  //   return barcodeScanRes;
  // }


  static Future<List<LibroIsarModel>> searchBooksByBarcode(String isbn) async {
    return await simpleGoogleBooksSearch(ParameterGoogleSearchModel(isbn: isbn),);

    // return lstResult.isNotEmpty
    //   ? DataSuccess(data: lstResult)
    //   : DataFailed("Nessun libro trovato con ISBN: $isbn", ActDataResult.notFound);
  }

  static Future<List<LibroIsarModel>> simpleGoogleBooksSearch(ParameterGoogleSearchModel googleSearchModel,) async {
    return (googleSearchModel.title != null ||
            googleSearchModel.author != null ||
            (googleSearchModel.isbn != null && googleSearchModel.isbn != "-1"))
        ? await GooleApisBooksService.getLibri(googleSearchModel, 0, -1)
        : [];
  }
}




// import 'package:book/features/libro/data/models/libro_isar.module.dart';
// import 'package:book/models/parameter_google_search.module.dart';
// import 'package:book/services/goole_apis_books_service.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//
// /// 9788804680604 : Il problema dei tre corpi
// ///
// class LibroSearchService {
//
//   static Future<String> scanBarcodeNormal() async {
//     String barcodeScanRes;
//
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
//     } on PlatformException {
//       barcodeScanRes = 'Impossibile ottenere la versione della piattaforma software/hardware.';
//     }
//
//     return barcodeScanRes;
//   }
//
//   static Future<List<LibroIsarModel>> searchBooksByBarcode(String isbn) async {
//     return await simpleGoogleBooksSearch(ParameterGoogleSearchModel(isbn: isbn));
//
//     // return lstResult.isNotEmpty
//     //   ? DataSuccess(data: lstResult)
//     //   : DataFailed("Nessun libro trovato con ISBN: $isbn", ActDataResult.notFound);
//   }
//
//   static Future<List<LibroIsarModel>> simpleGoogleBooksSearch(ParameterGoogleSearchModel googleSearchModel) async {
//     return (googleSearchModel.title != null || googleSearchModel.author != null || (googleSearchModel.isbn != null && googleSearchModel.isbn != "-1"))
//         ? await GooleApisBooksService.getLibri(googleSearchModel, 0, -1)
//         : [];
//   }
// }

// import 'package:book/features/libro/data/models/libro_isar.module.dart';
// import 'package:book/models/parameter_google_search.module.dart';
// import 'package:book/services/goole_apis_books_service.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';
// class LibroSearchService {
//
//   static Future<String> scanBarcodeNormal() async {
//     String? resultBarcode;
//
//     // codice inizio
//
//     // Creazione dell'istanza BarcodeScanner
//     final barcodeScanner = BarcodeScanner();
//
//     try {
//       // Esempio: scansione da immagine presa dalla galleria o fotocamera
//       final ImagePicker picker = ImagePicker();
//       final XFile? imageFile = await picker.pickImage(
//         source: ImageSource.camera,
//       ); // o ImageSource.gallery
//
//       if (imageFile != null) {
//         final inputImage = InputImage.fromFilePath(imageFile.path);
//
//         // Scansione barcode dall'immagine
//         final List<Barcode> barcodes = await barcodeScanner.processImage(
//           inputImage,
//         );
//
//         if (barcodes.isNotEmpty) {
//           // Prendo il testo del primo barcode rilevato
//           resultBarcode = barcodes.first.displayValue;
//         }
//       }
//     } catch (e) {
//       // Handle error se serve
//       print('Errore durante la scansione barcode: $e');
//     } finally {
//       // Chiudo il barcodeScanner per liberare risorse
//       barcodeScanner.close();
//     }
//
//     // codice fine
//
//     return resultBarcode ?? "";
//   }
//
//   static Future<List<LibroIsarModel>> searchBooksByBarcode(String isbn) async {
//     return await simpleGoogleBooksSearch(
//       ParameterGoogleSearchModel(isbn: isbn),
//     );
//
//     // return lstResult.isNotEmpty
//     //   ? DataSuccess(data: lstResult)
//     //   : DataFailed("Nessun libro trovato con ISBN: $isbn", ActDataResult.notFound);
//   }
//
//   static Future<List<LibroIsarModel>> simpleGoogleBooksSearch(
//     ParameterGoogleSearchModel googleSearchModel,
//   ) async {
//     return (googleSearchModel.title != null ||
//             googleSearchModel.author != null ||
//             (googleSearchModel.isbn != null && googleSearchModel.isbn != "-1"))
//         ? await GooleApisBooksService.getLibri(googleSearchModel, 0, -1)
//         : [];
//   }
// }

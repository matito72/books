

import 'dart:io';

import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_search_model.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/models/parameter_google_search_model.dart';
import 'package:books/services/libro_search_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';

class Utils {

  static Future<Image> getImageFromUrlFile(LibroViewModel libroViewModel, {double? w, double? h}) async {
    late Image image;

    if (libroViewModel.immagineCopertina.isNotEmpty) {
      File f = File(libroViewModel.immagineCopertina);
      if (f.existsSync()) {
        image = Image.file(File(libroViewModel.immagineCopertina), fit: BoxFit.fill,);
      } else {
        if (libroViewModel.immagineCopertina.toLowerCase().startsWith("http")) {
          if (w != null && h != null) {
            return Image.network(libroViewModel.immagineCopertina, height: h, width: w, fit: BoxFit.fill);
          } else {
            image = Image.network(libroViewModel.immagineCopertina, fit: BoxFit.fill);
          }
        } else {
          if (w != null && h != null) {
            image = Image.asset('assets/images/waiting.png', height: h, width: w, fit: BoxFit.fill);
          } else {
            image = Image.asset('assets/images/waiting.png',fit: BoxFit.fill);
          }
        }
      }
    } else {
      image = Image.asset('assets/images/waiting.png',fit: BoxFit.fill);
    }
    debugPrint('image.hashCode: ${image.hashCode}');
    return image;
  }
  
  static integrazioneDatiIncompleti(LibroViewModel libroViewModelDett) async {
    int nrDatiIncompleti = 0;
    nrDatiIncompleti += libroViewModelDett.descrizione.isEmpty ? 1 : 0;
    nrDatiIncompleti += (libroViewModelDett.editore.isEmpty || libroViewModelDett.editore == Constant.editoreDaDefinire) ? 1 : 0;
    nrDatiIncompleti += libroViewModelDett.lstAutori.isEmpty ? 1 : 0;
    nrDatiIncompleti += libroViewModelDett.dataPubblicazione.isEmpty ? 1 : 0;
    nrDatiIncompleti += (libroViewModelDett.nrPagine == 0) ? 1 : 0;
    nrDatiIncompleti += libroViewModelDett.prezzo.isEmpty ? 1 : 0;
    // nrDatiIncompleti += libroViewModelDett.immagineCopertina.contains('zoom=0') ? 0 : 1;

    if (nrDatiIncompleti != 0) {
      ParameterGoogleSearchModel googleSearchModel = ParameterGoogleSearchModel(
        title: libroViewModelDett.titolo, 
        author: libroViewModelDett.lstAutori.first, 
        casaEditrice: libroViewModelDett.editore
      );

      List<LibroViewModel> lstLibri = await LibroSearchService.simpleGoogleBooksSearch(googleSearchModel);
      if (lstLibri.isNotEmpty) {
        int nrTentativi = 10;
        for (LibroViewModel libroViewModelResult in lstLibri) {
          if (libroViewModelDett.descrizione.isEmpty && libroViewModelResult.descrizione.isNotEmpty) {
            libroViewModelDett.descrizione = libroViewModelResult.descrizione;
            nrDatiIncompleti--;
          }
          if (nrDatiIncompleti > 0 && (libroViewModelDett.editore.isEmpty || libroViewModelDett.editore == Constant.editoreDaDefinire) && libroViewModelResult.editore.isNotEmpty) {
            libroViewModelDett.editore = libroViewModelResult.editore;
            nrDatiIncompleti--;
          }
          if (nrDatiIncompleti > 0 && libroViewModelDett.lstAutori.isEmpty && libroViewModelResult.lstAutori.isNotEmpty) {
            libroViewModelDett.lstAutori = libroViewModelResult.lstAutori;
            nrDatiIncompleti--;
          }
          if (nrDatiIncompleti > 0 && libroViewModelDett.dataPubblicazione.isEmpty && libroViewModelResult.dataPubblicazione.isNotEmpty) {
            libroViewModelDett.dataPubblicazione = libroViewModelResult.dataPubblicazione;
            nrDatiIncompleti--;
          }
          if (nrDatiIncompleti > 0 && (libroViewModelDett.nrPagine == 0) && (libroViewModelResult.nrPagine != 0)) {
            libroViewModelDett.nrPagine = libroViewModelResult.nrPagine;
            nrDatiIncompleti--;
          }
          if (nrDatiIncompleti > 0 && libroViewModelDett.prezzo.isEmpty && libroViewModelResult.prezzo.isNotEmpty) {
            libroViewModelDett.prezzo = libroViewModelResult.prezzo;
            nrDatiIncompleti--;
          }
          
          // if (!libroViewModelDett.immagineCopertina.contains('zoom=0')) {
          //   await Utils.checkImage(libroViewModelDett);
          //   nrTentativi--;
          // }

          nrTentativi--;
          if (nrDatiIncompleti <= 0 || nrTentativi <= 0) {
            break;
          }
        }
      }
    }
  }

  static checkImage(LibroSearchModel libroViewModel) async {
    String immagineCopertina = libroViewModel.immagineCopertina;
    if (immagineCopertina != '') {
      String textImgOrig = await getTextFromUrlImage(immagineCopertina);
      String textImgNew = textImgOrig;

      if (immagineCopertina.contains('zoom=1')) {
        immagineCopertina = '${immagineCopertina.replaceFirst('zoom=1', 'zoom=0')}&fife=w400-h600';
        textImgNew = await getTextFromUrlImage(immagineCopertina);
      } else if (immagineCopertina.contains('zoom=5')) {
        immagineCopertina = '${immagineCopertina.replaceFirst('zoom=5', 'zoom=0')}&fife=w400-h600';
        textImgNew = await getTextFromUrlImage(immagineCopertina);
      } 

      if (textImgNew != textImgOrig) {
        immagineCopertina = libroViewModel.immagineCopertina.replaceFirst('zoom=0', 'zoom=5');
      }


      // NetworkAssetBundle net = NetworkAssetBundle(Uri.parse(immagineCopertina));
      // var data = await net.load(immagineCopertina);
      // Uint8List bytes = data.buffer.asUint8List();

      // bool isText = false;
      // try {
      //   var buffer = bytes.buffer;
      //   ByteData byteData = ByteData.view(buffer);
      //   var tempDir = await getTemporaryDirectory();
      //   File imageFile = await File('${tempDir.path}/img').writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));      

      //   final inputImage = InputImage.fromFile(imageFile);
      //   final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      //   final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      //   String text = recognizedText.text;
      //   textRecognizer.close();
      //   isText = text.replaceAll('\n', '') == "imagenotavailable";
      //   // imageFile.delete();
      // } catch(e) {
      //   // print('Errore=$e'); 
      // }     
      
      // if (isText) {
      //   immagineCopertina = libroViewModel.immagineCopertina.replaceFirst('zoom=0', 'zoom=5');
      //   // libroViewModel.immagineCopertina = "https://covers.openlibrary.org/b/isbn/${libroViewModel.isbn}-L.jpg";
      // } 

      // else {
      //   debugPrint("Titolo: ${libroViewModel.titolo} => URL:${libroViewModel.immagineCopertina}");
      //   debugPrint("LENGTH: ${bytes.length}");
      //   debugPrint("....");
      // }
      

      libroViewModel.immagineCopertina = immagineCopertina;
    }
  }

  static Future<String> getTextFromUrlImage(String immagineCopertina) async {
    NetworkAssetBundle net = NetworkAssetBundle(Uri.parse(immagineCopertina));
    var data = await net.load(immagineCopertina);
    Uint8List bytes = data.buffer.asUint8List();

    String text = '';
    try {
      var buffer = bytes.buffer;
      ByteData byteData = ByteData.view(buffer);
      var tempDir = await getTemporaryDirectory();
      File imageFile = await File('${tempDir.path}/img').writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));      

      final inputImage = InputImage.fromFile(imageFile);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      text = recognizedText.text;
      textRecognizer.close();
    } catch(e) {
      text = '';
    }

    return text;
  }
}
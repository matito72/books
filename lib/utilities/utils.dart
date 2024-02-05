import 'dart:io';
import 'dart:math';

import 'package:books/config/constant.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/models/parameter_google_search.module.dart';
import 'package:books/services/libro_search_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter/widgets.dart';

class Utils {

  static Future<Image> getImageFromUrlFile(LibroViewModel libroViewModel, {double? w, double? h}) async {
    late Image image;

    if (libroViewModel.immagineCopertina.isNotEmpty) {
      File f = File(libroViewModel.immagineCopertina);
      if (f.existsSync()) {
        if (w != null && h != null) {
          image = Image.file(
            height: h, 
            width: w,
            File(libroViewModel.immagineCopertina), fit: BoxFit.fill
          );
        } else {
          image = Image.file(File(libroViewModel.immagineCopertina), fit: BoxFit.fill,);
        }
      } else {
        if (libroViewModel.immagineCopertina.toLowerCase().startsWith("http")) {
          if (w != null && h != null) {
            // Image img = Image.network(libroViewModel.immagineCopertina, height: h, width: w, fit: BoxFit.fill);
            Image img = Image.network(
              libroViewModel.immagineCopertina,
              // fit: BoxFit.fill,
              fit: BoxFit.contain,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            );
            
            return img;
          } else {
            image = Image.network(libroViewModel.immagineCopertina, fit: BoxFit.fill);
          }
        } else {
          if (w != null && h != null) {
            image = Image.asset(Constant.assetImageDefault, height: h, width: w, fit: BoxFit.fill);
          } else {
            image = Image.asset(Constant.assetImageDefault,fit: BoxFit.fill);
          }
        }
      }
    } else {
      image = Image.asset(Constant.assetImageDefault,fit: BoxFit.fill);
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

  static Future<List<String>> simpleGoogleCoverBookSearch(LibroViewModel libroViewModelDett, int nrMax) async {
    List<String> lstCoverBookUrl = [];
    List<String> lstCoverBookUrlLowResolution = [];
    ParameterGoogleSearchModel googleSearchModel = ParameterGoogleSearchModel(
      title: libroViewModelDett.titolo, 
      author: libroViewModelDett.lstAutori.first, 
      casaEditrice: libroViewModelDett.editore
    );

    bool stop = false;

    while (!stop) {
      List<LibroViewModel> lstLibri = await LibroSearchService.simpleGoogleBooksSearch(googleSearchModel);
      if (lstLibri.isNotEmpty) {
        _loadCoverBook(lstCoverBookUrlLowResolution, lstCoverBookUrl, lstLibri, (nrMax - lstCoverBookUrl.length));
      }

      if (lstCoverBookUrl.length >= nrMax) {
        stop = true;
      } else {
        if (googleSearchModel.casaEditrice != null) {
          googleSearchModel.casaEditrice = null;
        } else if (googleSearchModel.author != null) {
          googleSearchModel.author = null;
        } else if (googleSearchModel.title != null) {
          googleSearchModel.title = null;
          googleSearchModel.author = libroViewModelDett.lstAutori.first;
        } else {
          stop = true;
        }
      }
    }

    if (libroViewModelDett.pathImmagineCopertina != null && libroViewModelDett.pathImmagineCopertina!.trim().isNotEmpty) {
      _loadHttpUrl(lstCoverBookUrl, libroViewModelDett.pathImmagineCopertina!);
    }

    int i = 0;
    while (lstCoverBookUrl.length < 3) {
      if (lstCoverBookUrlLowResolution.isNotEmpty && lstCoverBookUrlLowResolution.length > i) {
        _loadHttpUrl(lstCoverBookUrl, lstCoverBookUrlLowResolution[i++]);
      } else {
        _loadHttpUrl(lstCoverBookUrl, libroViewModelDett.immagineCopertina);
      }
    }

    return lstCoverBookUrl;
  }

  static _loadHttpUrl(List<String> lstCoverBookHttpUrl, String url) {
    if (url.toLowerCase().startsWith('http') && !lstCoverBookHttpUrl.contains(url)) {
      lstCoverBookHttpUrl.add(url);
    }
  }

  static _loadCoverBook(List<String> lstCoverBookUrlLowResolution, List<String> lstCoverBookUrl, List<LibroViewModel> lstLibri, int nrMax) {
    if (lstLibri.isNotEmpty) {
      for (LibroViewModel libroViewModelResult in lstLibri) {
        String immagineCopertina = libroViewModelResult.immagineCopertina;
        if (immagineCopertina.trim().isEmpty) {
          continue;
        }
        if (!lstCoverBookUrlLowResolution.contains(immagineCopertina)) {
          _loadHttpUrl(lstCoverBookUrlLowResolution, immagineCopertina);
        }

        if (lstCoverBookUrl.length < nrMax) {
          if (immagineCopertina.contains('zoom=1')) {
            immagineCopertina = '${immagineCopertina.replaceFirst('zoom=1', 'zoom=0')}&fife=w400-h600';
          } else if (libroViewModelResult.immagineCopertina.contains('zoom=5')) {
            immagineCopertina = '${immagineCopertina.replaceFirst('zoom=5', 'zoom=0')}&fife=w400-h600';
          } else {
            debugPrint('immagineCopertina: $immagineCopertina');
          }

          if (!lstCoverBookUrl.contains(immagineCopertina)) {
            _loadHttpUrl(lstCoverBookUrl, immagineCopertina);
          }
        }
      }
    }
  }

  static String getListToString(List<String> lstStr) {
    String ret = lstStr.toString();
    return ret.substring(1, ret.length - 1);
  }

  static double getPositiveDouble(String strDouble) {
    double ret = 0;
    try {
      ret = double.parse(strDouble);
      if (ret < 0) {
        throw 'Attenzione: $strDouble risulta NEGATIVO [$ret] !!!';
      }
    } on Exception {
      ret = -1;
    }

    return ret;
  }

  static String getFirstSubstring(String str, int n) {
    if (str.length <= (n + 3)) {
      return str;
    }
    return '${str.substring(0, (n - 3))}...';
  }

  static String getLastSubstring(String str, int n) {
    if (str.length <= n) {
      return str;
    }
    return str.substring(str.length - n);
  }

  /// Es.: 202401161828010011234
  ///
  static String getDataNow() {
    DateTime now = DateTime.now();
    String strMonth = NumberFormat("00").format(now.month);
    String strDay = NumberFormat("00").format(now.day);
    String strHour = NumberFormat("00").format(now.hour);
    String strMinute = NumberFormat("00").format(now.minute);
    String strSecond = NumberFormat("00").format(now.second);
    String strMillisecond = NumberFormat("000").format(now.millisecond);
    // String strMicrosecond = NumberFormat("000").format(now.microsecond);
    // String nr999 = NumberFormat("0000").format(Random().nextInt(999));

    return '${now.year}$strMonth$strDay$strHour$strMinute$strSecond$strMillisecond${now.microsecond}';
  } 

  /// Es.: GEN_123456789
  /// 
  static String getIsbnGenAutoNotNull() {
    String nr = NumberFormat("0000000000").format(Random().nextInt(999999999));
    return 'GEN$nr';
  } 

  static Map<int, String> getMapCodDescLibreria(List<LibreriaIsarModel> lstLibrerieInUso) {
    Map<int, String> mapCodDescLibreria = {};
    if (lstLibrerieInUso.isNotEmpty) {
      for (LibreriaIsarModel libreriaIsarModel in lstLibrerieInUso) {
        mapCodDescLibreria.putIfAbsent(libreriaIsarModel.sigla, () => libreriaIsarModel.nome);        
      }
    }
    return mapCodDescLibreria;
  }
}
import 'dart:async';
import 'dart:convert';
import 'package:books/config/constant.dart';
// import 'package:books/features/libro/data/models/libro_search_model.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/models/parameter_google_search_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class GooleApisBooksService {

  static Future<List<LibroViewModel>> getLibri(ParameterGoogleSearchModel googleSearchModel, int offset, int limit) async {
    GooleApisBooksService gooleApisBooksService = GooleApisBooksService();

    return gooleApisBooksService.cercaLibri(googleSearchModel, offset);
  }

  Future<List<LibroViewModel>> cercaLibri(ParameterGoogleSearchModel googleSearchModel, int offset) async {
        // {String? id, String? barcode, List<String>? filters, String? title, String? author, String? genericParam, int startIndex = -1}) async {
    List<LibroViewModel> libri = [];
    String percorso = Constant.googleapisPercorso;
    
    Map<String, dynamic> parametri = {};

    if (googleSearchModel.id != null && googleSearchModel.id!.isNotEmpty) {
      percorso += '/${googleSearchModel.id}';
    } else {
      // ------- PARAMETRI -------
      List<String> qParams = [];
      if (googleSearchModel.isbn != null && googleSearchModel.isbn!.trim().isNotEmpty) {
        qParams.add('isbn:${googleSearchModel.isbn}');
      }
      if (googleSearchModel.title != null && googleSearchModel.title!.trim().isNotEmpty) {
        qParams.add('intitle:${googleSearchModel.title}');
      }
      if (googleSearchModel.author != null && googleSearchModel.author!.trim().isNotEmpty) {
        qParams.add('inauthor:${googleSearchModel.author}');
      }
      if (googleSearchModel.genericParam != null && googleSearchModel.genericParam!.trim().isNotEmpty) {
        qParams.add(googleSearchModel.genericParam!);
      }
      if (qParams.isNotEmpty) {
        parametri.putIfAbsent('q', () => qParams.join('+'));
      }
      
      // ------- FILTRI -------
      if (googleSearchModel.filters != null && googleSearchModel.filters!.isNotEmpty) {
        parametri.putIfAbsent('filter', () => googleSearchModel.filters!.join('&'));
      }
      // if (startIndex != -1) {
      // }
      
      parametri.putIfAbsent('startIndex', () => offset.toString());
      // parametri.putIfAbsent('maxResults', () => 10.toString());
    }

    final Uri url = Uri.https(Constant.googleapisDominio, percorso, parametri);
    
    try {
        // print('URL: ${url.toString()}');

      await http.get(url).then((res) {
        final resJson = json.decode(res.body);
        final libriMap = resJson['items'] ?? resJson;
        int nrLibriTrovati = resJson['totalItems'] ?? (resJson['volumeInfo'] != null ? 1 : 0);
        
        if (nrLibriTrovati != 0) {
          // if (_totalItems == -1) {
          //   _totalItems = nrLibriTrovati;
          // }

          if (libriMap == resJson) {
            libri.add(LibroViewModel.fromGoogleMap(libriMap));
          } else {
            libri.addAll(libriMap.map<LibroViewModel>((mappa) => LibroViewModel.fromGoogleMap(mappa)).toList()); 
          }
          
          // print('================================================================================================');
          debugPrint('N: ${libri.length}');
          // print('================================================================================================');
          // print(libri);
          // print('================================================================================================');
        } 
      });
    } catch (errore) {
      debugPrint("ERRORE: ${errore.toString()}");
      rethrow;
    }  

    return libri;
  }
}
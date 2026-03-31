import 'dart:async';
import 'dart:convert';

import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/models/parameter_google_search.module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class GooleApisBooksService {

  static Future<List<LibroIsarModel>> getLibri(ParameterGoogleSearchModel googleSearchModel, int offset, bool isWithApiKey) async {
    GooleApisBooksService gooleApisBooksService = GooleApisBooksService();

    return gooleApisBooksService._cercaLibri(googleSearchModel, offset, isWithApiKey);
  }

  Future<List<LibroIsarModel>> _cercaLibri(ParameterGoogleSearchModel googleSearchModel, int offset, bool isWithApiKey) async {
    List<LibroIsarModel> libri = [];
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
        qParams.add('inauthor:${getConcatStrSearch(googleSearchModel.author!)}');
      }
      if (googleSearchModel.casaEditrice != null && googleSearchModel.casaEditrice!.trim().isNotEmpty) {
        qParams.add('inpublisher:${getConcatStrSearch(googleSearchModel.casaEditrice!)}');
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

    // BOOKS-API-KEY
    final String apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'] ?? '';

    Uri url = Uri.https(Constant.googleapisDominio, percorso, parametri);
    if (isWithApiKey) {
      url = Uri.parse(Uri.decodeComponent("$url&key=$apiKey"));
    }

    try {
      print('URL: ${url.toString()}');

      await http.get(url).then((res) async {
        final resJson = json.decode(res.body);
        final libriMap = resJson['items'] ?? resJson;
        int nrLibriTrovati = resJson['totalItems'] ?? (resJson['volumeInfo'] != null ? 1 : 0);

        if (nrLibriTrovati != 0) {
          // if (_totalItems == -1) {
          //   _totalItems = nrLibriTrovati;
          // }

          if (libriMap == resJson) {
            LibroIsarModel libroViewModel = LibroIsarModel.fromGoogleMap(libriMap);
            //await Utils.checkImage(libroViewModel);
            libri.add(libroViewModel);
          } else {
            for (var map in libriMap) {
              LibroIsarModel libroViewModel = LibroIsarModel.fromGoogleMap(map);
              //await Utils.checkImage(libroViewModel);
              libri.add(libroViewModel);
            }
            // libri.addAll(libriMap.map<LibroViewModel>((mappa) => LibroViewModel.fromGoogleMap(mappa)).toList());
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

  String getConcatStrSearch(String author) {
    if (!author.contains(" ")) {
      return '"$author"';
    }

    return '"${author.split(' ').map((s) => s.trim()).join('+')}"';
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/models/parameter_google_search.module.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class GooleApisBooksService {

  static Future<List<LibroViewModel>> getLibri(ParameterGoogleSearchModel googleSearchModel, int offset, int limit) async {
    GooleApisBooksService gooleApisBooksService = GooleApisBooksService();

    return gooleApisBooksService.cercaLibri(googleSearchModel, offset);
  }

  Future<List<LibroViewModel>> cercaLibri(ParameterGoogleSearchModel googleSearchModel, int offset) async {
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
        qParams.add('inauthor:${getStrSearchAutore(googleSearchModel.author!)}');
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

      await http.get(url).then((res) async {
        final resJson = json.decode(res.body);
        final libriMap = resJson['items'] ?? resJson;
        int nrLibriTrovati = resJson['totalItems'] ?? (resJson['volumeInfo'] != null ? 1 : 0);
        
        if (nrLibriTrovati != 0) {
          // if (_totalItems == -1) {
          //   _totalItems = nrLibriTrovati;
          // }

          if (libriMap == resJson) {
            LibroViewModel libroViewModel = LibroViewModel.fromGoogleMap(libriMap);
            //await Utils.checkImage(libroViewModel);
            libri.add(libroViewModel);
          } else {
            for (var map in libriMap) {
              LibroViewModel libroViewModel = LibroViewModel.fromGoogleMap(map);
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

  String getStrSearchAutore(String author) {
    if (!author.contains(" ")) {
      return '"$author"';
    }

    return '"${author.split(' ').map((s) => s.trim()).join('+')}"';
  }

  // readImageFromAmazon(LibroViewModel libroViewModel) async {
  //   if (libroViewModel.isbn.isEmpty) {
  //     return;
  //   }
    
  //   final Uri url = Uri.https(
  //     "https://covers.openlibrary.org", "/b/isbn/${libroViewModel.isbn}-L.jpg"
  //   );

    
    
  //   // UserAgentClient u = UserAgentClient(
  //   //   "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36", 
  //   //   http.BaseClient)
    
  //   try {
  //     final client = UserAgentClient("Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome", http.Client());
  //     // await http.get(url).then((res) {
  //     await client.get(url).then((res) {
  //       String html = res.body;

  //       int i = html.indexOf("https://m.media-amazon.com/images/I/");
        
  //       debugPrint(html);
  //     });
  //   } catch (errore) {
  //     debugPrint("ERRORE: ${errore.toString()}");
  //     rethrow;
  //   } 
  // }
}

// class UserAgentClient extends http.BaseClient {
//   final String userAgent;
//   final http.Client _inner;

//   UserAgentClient(this.userAgent, this._inner);

//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     request.headers['user-agent'] = userAgent;
//     return _inner.send(request);
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:book/models/parameter_google_search.module.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';

class OpenLibraryService {

  static Future<List<LibroIsarModel>> getLibri(ParameterGoogleSearchModel googleSearchModel, int offset) async {
    OpenLibraryService openLibraryService = OpenLibraryService();
    return openLibraryService._cercaLibri(googleSearchModel, offset);
  }

  Future<List<LibroIsarModel>> _cercaLibri(ParameterGoogleSearchModel parameterSearchModel, int offset) async {
    List<LibroIsarModel> libri = [];
    const int pageSize = 10; // Deve corrispondere al pageSize del tuo widget

    try {
      // Calcoliamo la pagina (Open Library parte da pagina 1)
      int pageNumber = (offset / pageSize).floor() + 1;

      final queryParameters = <String, String>{
        'limit': pageSize.toString(),
        'page': pageNumber.toString(),
      };

      // Aggiunta filtri dinamici
      if (parameterSearchModel.isbn != null && parameterSearchModel.isbn!.trim().isNotEmpty) {
        queryParameters['isbn'] = parameterSearchModel.isbn!;
      }
      if (parameterSearchModel.title != null && parameterSearchModel.title!.trim().isNotEmpty) {
        queryParameters['title'] = parameterSearchModel.title!;
      }
      if (parameterSearchModel.author != null && parameterSearchModel.author!.trim().isNotEmpty) {
        queryParameters['author'] = parameterSearchModel.author!;
      }
      if (parameterSearchModel.casaEditrice != null && parameterSearchModel.casaEditrice!.trim().isNotEmpty) {
        queryParameters['publisher'] = parameterSearchModel.casaEditrice!;
      }

      if (queryParameters.length <= 2) return []; // Solo limit e page presenti

      final uri = Uri.https('openlibrary.org', '/search.json', queryParameters);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List docs = data['docs'] ?? [];

        libri = docs.map((bookMap) => LibroIsarModel.fromOpenlibraryMap(bookMap)).toList();
      } else {
        throw Exception("Errore API: ${response.statusCode}");
      }

    } catch (errore) {
      debugPrint("ERRORE: $errore");
      rethrow;
    }

    return libri;
  }

  /*
  openlibrary
    RICERCA AUTORE:
        https://openlibrary.org/search/authors.json?q=j%20k%20rowling   <=== cercato: "J. K. Rowling"       
    
    RICERCA: autore e titolo, isbn
        https://openlibrary.org/search.json?author=alberto+angela&tilte=i+tre+giorni+di+pompei
        
        https://openlibrary.org/search.json?isbn=9788817077309
        
            http://covers.openlibrary.org/b/olid/OL30823014M-L.jpg      <===  BOOK
            https://covers.openlibrary.org/a/olid/OL1026534A-L.jpg      <=== FACCIA
    
    
    
    https://openlibrary.org/search.json?author=zerocalcare&tilte=scheletri
    https://openlibrary.org/search.json?isbn=9788832734898
    http://covers.openlibrary.org/b/olid/OL44012731M-L.jpg
  */
}
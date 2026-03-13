import 'dart:convert';

import 'package:book/config/com_area.dart';
import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/link_isar.module.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/resources/bisac_codes.dart';
import 'package:book/utilities/utils.dart';
import 'package:isar_community/isar.dart';
import 'package:crypto/crypto.dart';

// import 'libro_isar.module.util.dart';

part 'libro_isar.module.g.dart';

/// Modello like-GOOGLE-BOOK
///
///** flutter pub run build_runner build */

@Collection()
class LibroIsarModel {
  Id id = Isar.autoIncrement;

  // Google-Book
  late String googleBookId;
  late String isbn;

  late String titolo;
  late String editore;

  @Index(
    composite: [
      CompositeIndex('titolo', caseSensitive: false),
      CompositeIndex('editore', caseSensitive: false),
    ],
  )
  late List<String> lstAutori;
  late String descrizione;
  late String immagineCopertina;
  late String dataPubblicazione;
  late int nrPagine;
  late List<String> lstCategoria;
  late String previewLink;
  late bool isEbook;
  late String country;
  late String valuta;
  late double prezzo;
  // Valori gestiti: 1=Google, 2=Opne Library
  late int typeBookSearch;

  // view
  late int stars;
  String? pathImmagineCopertina; // Campo usato come 'backup' del campo 'immagineCopertina' originale
  late int siglaLibreria;
  late String note;
  late String dataInserimento;
  late String dataUltimaModifica;

  final IsarLinks<LinkIsarModule> lstLinkIsarModule = IsarLinks<LinkIsarModule>();
  final IsarLinks<PdfIsarModule> lstPdfIsarModule = IsarLinks<PdfIsarModule>();

  @ignore
  final List<PdfIsarModule> lstPdfModule = [];
  @ignore
  final List<LinkIsarModule> lstLinkModule = [];

  LibroIsarModel(
    this.siglaLibreria,
    this.dataInserimento,
    this.dataUltimaModifica, {
    this.googleBookId = '',
    required this.isbn,
    this.titolo = '',
    this.lstAutori = const [],
    this.editore = '',
    this.descrizione = '',
    this.immagineCopertina = '',
    this.dataPubblicazione = '',
    this.nrPagine = 0,
    this.lstCategoria = const [],
    this.previewLink = '',
    this.typeBookSearch = 0,
    this.isEbook = false,
    this.country = '',
    this.valuta = '',
    this.prezzo = 0,
    this.stars = 0,
    this.pathImmagineCopertina,
    this.note = '',
  }) {
    if (lstCategoria.isEmpty) {
      lstCategoria = [BisacList.nonClassifiable];
    }
    if (prezzo < 0) {
      prezzo = 0;
    }
  }

  Map<String, dynamic> toJson() => {
    'googleBookId': googleBookId,
    'isbn': isbn.trim().isNotEmpty ? isbn : '',
    'titolo': titolo,
    'autori': jsonEncode(lstAutori),
    'editore': editore,
    'descrizione': descrizione,
    'immagineCopertina': immagineCopertina,
    'dataPubblicazione': dataPubblicazione,
    'nrPagine': nrPagine,
    'lstCategoria': jsonEncode(lstCategoria),
    'previewLink': previewLink,
    'typeBookSearch': typeBookSearch,
    'isEbook': isEbook,
    'country': country,
    'valuta': valuta,
    'prezzo': prezzo,
    'stars': stars,
    'pathImmagineCopertina': pathImmagineCopertina,
    'siglaLibreria': siglaLibreria,
    'note': note,
    'dataInserimento': dataInserimento,
    'ultimaModifica': dataUltimaModifica,
    'lstPdfIsarModule': lstPdfIsarModule.map((pdf) => pdf.toJson()).toList(),
    'lstLinkIsarModule': lstLinkIsarModule.map((link) => link.toJson()).toList(),
  };

  Map<String, dynamic> toJsonExcel() => {
    'googleBookId': googleBookId,
    'isbn': isbn.trim().isNotEmpty ? isbn : '',
    'titolo': titolo,
    'autori': jsonEncode(lstAutori),
    'editore': editore,
    'descrizione': descrizione,
    'immagineCopertina': immagineCopertina,
    'dataPubblicazione': dataPubblicazione,
    'nrPagine': nrPagine,
    'lstCategoria': jsonEncode(lstCategoria),
    'previewLink': previewLink,
    'typeBookSearch': typeBookSearch,
    'isEbook': isEbook,
    'country': country,
    'valuta': valuta,
    'prezzo': prezzo,
    'stars': stars,
    'pathImmagineCopertina': pathImmagineCopertina,
    'siglaLibreria': siglaLibreria,
    'note': note,
    'dataInserimento': dataInserimento,
    'ultimaModifica': dataUltimaModifica
  };

  LibroIsarModel.fromMap(
    Map<String, dynamic> mappa, {
    this.stars = 0,
    this.siglaLibreria = 0,
    this.dataInserimento = Constant.dataDefault,
    this.dataUltimaModifica = Constant.dataDefault,
    this.note = '',
  }) {
    isbn = mappa['isbn'];
    titolo = mappa['titolo'];
    lstAutori = List<String>.from(jsonDecode(mappa['autori']));
    editore = mappa['editore'];
    descrizione = mappa['descrizione'];
    immagineCopertina = mappa['immagineCopertina'];
    dataPubblicazione = mappa['dataPubblicazione'];
    nrPagine = mappa['nrPagine'];
    lstCategoria = _getListaCategoriaFromMap(mappa['lstCategoria']);
    previewLink = mappa['previewLink'];
    typeBookSearch = mappa['typeBookSearch'] ?? 1;
    isEbook = mappa['isEbook'];
    country = mappa['country'];
    valuta = mappa['valuta'];
    prezzo = (mappa['prezzo'] is double)
        ? mappa['prezzo']
        : Utils.getPositiveDouble(
            Utils.getTrimUppercaseParameter(mappa['prezzo']),
          );
    googleBookId = mappa['id'] ?? mappa['googleBookId'];
    stars = mappa['stars'];
    pathImmagineCopertina = mappa['pathImmagineCopertina'];
    siglaLibreria = ComArea.libreriaInUso!.sigla;
    note = mappa['note'] ?? '';

    final List<dynamic>? pdfMaps = mappa['lstPdfIsarModule'];
    if (pdfMaps != null) {
      for (final map in pdfMaps) {
        // Si assume l'esistenza di PdfIsarModule.fromMap
        PdfIsarModule pdfIsarModule = PdfIsarModule.fromMap(map as Map<String, dynamic>);
        lstPdfModule.add(pdfIsarModule);
      }
    }

    final List<dynamic>? linkMaps = mappa['lstLinkIsarModule'];
    if (linkMaps != null) {
      for (final map in linkMaps) {
        LinkIsarModule linkIsarModule = LinkIsarModule.fromMap(map as Map<String, dynamic>);
        lstLinkModule.add(linkIsarModule);
      }
    }
  }

  List<String> _getListaCategoriaFromMap(dynamic lstCategoria) {
    if (lstCategoria != null) {
      return List<String>.from(jsonDecode(lstCategoria));
    }

    return [BisacList.nonClassifiable];
  }

  LibroIsarModel clonaLibro() => LibroIsarModel(
    siglaLibreria,
    dataInserimento,
    dataUltimaModifica,
    note: note,
    googleBookId: googleBookId,
    isbn: isbn,
    titolo: titolo,
    lstAutori: lstAutori,
    editore: editore,
    descrizione: descrizione,
    immagineCopertina: immagineCopertina,
    dataPubblicazione: dataPubblicazione,
    nrPagine: nrPagine,
    lstCategoria: lstCategoria,
    previewLink: previewLink,
    typeBookSearch: typeBookSearch,
    isEbook: isEbook,
    country: country,
    valuta: valuta,
    prezzo: prezzo,
    stars: stars,
    pathImmagineCopertina: pathImmagineCopertina,
  );

  /// Al salvataggio del Libro, dalla lista dei libri cercati:
  ///
  void loadDataFromLibroViewModel(LibroIsarModel libroViewModel) {
    googleBookId = libroViewModel.googleBookId;
    isbn = libroViewModel.isbn;
    country = libroViewModel.country;
    titolo = libroViewModel.titolo;
    editore = libroViewModel.editore;
    descrizione = libroViewModel.descrizione;
    immagineCopertina = libroViewModel.immagineCopertina;
    dataPubblicazione = libroViewModel.dataPubblicazione;
    previewLink = libroViewModel.previewLink;
    typeBookSearch = libroViewModel.typeBookSearch;
    valuta = libroViewModel.valuta;
    prezzo = libroViewModel.prezzo;
    nrPagine = libroViewModel.nrPagine;
    lstCategoria = libroViewModel.lstCategoria;
    isEbook = libroViewModel.isEbook;
    lstAutori = libroViewModel.lstAutori;
    stars = libroViewModel.stars;
  }

  LibroIsarModel.fromGoogleMap(
    Map<String, dynamic> mappa, {
    this.stars = 0,
    this.siglaLibreria = 0,
    this.dataInserimento = Constant.dataDefault,
    this.dataUltimaModifica = Constant.dataDefault,
    this.note = '',
  }) {
    const String strNullValue = '';

    googleBookId = mappa['id'] ?? mappa['googleBookId'];

    Map<String, dynamic> mapVolumeInfo = mappa['volumeInfo'];
    titolo = mapVolumeInfo['title'];
    if (mapVolumeInfo['authors'] != null) {
      lstAutori = (mapVolumeInfo['authors'] as List)
          .map((item) => item as String)
          .toList();
    } else {
      lstAutori = ['<Autore da definire>'];
    }
    descrizione = mapVolumeInfo['description'] ?? strNullValue;
    descrizione = descrizione.replaceAll('<i>', '');
    descrizione = descrizione.replaceAll('<br>', '');
    descrizione = descrizione.replaceAll('</i>', '');
    descrizione = descrizione.replaceAll('<b>', '');
    descrizione = descrizione.replaceAll('</b>', '');

    editore = mapVolumeInfo['publisher'] ?? Constant.editoreDaDefinire;

    List industryIdentifiers = mapVolumeInfo['industryIdentifiers'] ?? [];
    if (industryIdentifiers.isNotEmpty && industryIdentifiers.length > 1) {
      isbn = industryIdentifiers.elementAt(
        industryIdentifiers.length - 1,
      )['identifier'];
    } else {
      isbn = '';
    }

    dataPubblicazione = mapVolumeInfo['publishedDate'] ?? strNullValue;
    nrPagine = mapVolumeInfo['pageCount'] ?? 0;

    if (mapVolumeInfo['categories'] != null) {
      lstCategoria = (mapVolumeInfo['categories'] as List)
          .map((item) => (item as String).toUpperCase())
          .toList();
      // if (lstCategoria.length > 1) {
      //   print('==============================================================> ${lstCategoria.toString()} <==========================================');
      // }
    } else {
      lstCategoria = [
        BisacList.nonClassifiable,
      ]; // mapVolumeInfo['categories'] ?? [];
    }

    previewLink = mapVolumeInfo['previewLink'] ?? strNullValue;
    typeBookSearch = 1;

    try {
      immagineCopertina = mapVolumeInfo['imageLinks']['smallThumbnail'] ?? strNullValue;
    } catch (errore) {
      immagineCopertina = strNullValue;
    }

    Map<String, dynamic> saleInfo = mappa['saleInfo'] ?? {};
    isEbook = saleInfo['isEbook'] ?? false;
    country = saleInfo['country'] ?? strNullValue;

    valuta = strNullValue;
    prezzo = 0;

    if (isEbook) {
      Map<String, dynamic> mapListPrice = saleInfo['listPrice'] ?? {};
      valuta = mapListPrice['currencyCode'] ?? strNullValue;
      String strPrezzo = (mapListPrice['amount'] != null)
          ? mapListPrice['amount'].toString()
          : "0";
      if (double.tryParse(strPrezzo) != null) {
        prezzo = double.parse(strPrezzo);
      }
    }
  }

  LibroIsarModel.fromOpenlibraryMap(
      Map<String, dynamic> mappa, {
        this.stars = 0,
        this.siglaLibreria = 0,
        this.dataInserimento = '2000-01-01', // Esempio costante
        this.dataUltimaModifica = '2000-01-01',
        this.note = '',
      }) {
    // Open Library Search API usa 'key' (es: /works/OL123W)
    googleBookId = mappa['key'] ?? '';

    // Prende il primo ISBN disponibile nella lista
    isbn = (mappa['isbn'] as List?)?.first ?? '';

    titolo = mappa['title'] ?? 'Titolo non disponibile';

    // Editore: prende il primo della lista
    editore = (mappa['publisher'] as List?)?.first ?? 'Editore sconosciuto';

    // Autori: mappa la lista di stringhe
    lstAutori = List<String>.from(mappa['author_name'] ?? []);

    descrizione = ""; // La ricerca base non fornisce la descrizione completa (servirebbe un'altra chiamata al work ID)

    // Immagine copertina tramite Cover ID
    if (mappa['cover_i'] != null) {
      immagineCopertina = "https://covers.openlibrary.org/b/id/${mappa['cover_i']}-L.jpg";
    } else {
      immagineCopertina = "";
    }

    dataPubblicazione = (mappa['publish_date'] as List?)?.first ?? '';
    nrPagine = mappa['number_of_pages_median'] ?? 0;

    // -----------------------------------------------------------------------------------
    // lstCategoria = List<String>.from(mappa['subject'] ?? []);
    // Recuperiamo i soggetti dall'API
    List<dynamic>? subjectsFromApi = mappa['subject'];

    // Assegniamo alla tua lista di categorie il valore mappato
    // Nota: dato che lstCategoria è una List<String>, possiamo mettere il risultato del mapping
    String categoriaMappata = mapOpenLibraryToBisac(subjectsFromApi);

    lstCategoria = [categoriaMappata];
    // -----------------------------------------------------------------------------------

    previewLink = mappa['key'] != null ? "https://openlibrary.org${mappa['key']}" : "";
    typeBookSearch = 2;

    // Campi default/non presenti in questa API
    isEbook = mappa['has_fulltext'] ?? false;
    country = "IT";
    valuta = "EUR";
    prezzo = 0.0;
  }

  String mapOpenLibraryToBisac(List<dynamic>? olSubjects) {
    if (olSubjects == null || olSubjects.isEmpty) return "nonClassifiable";

    // Trasformiamo tutto in minuscolo per un confronto facile
    final subjects = olSubjects.map((s) => s.toString().toLowerCase()).toList();

    // Definiamo delle parole chiave per il mapping
    // Puoi espandere questa mappa per coprire più casi
    Map<String, List<String>> keywordMap = {
      'COOKING': ['cooking', 'cuisine', 'food', 'gastronomy', 'ricette', 'cucina'],
      'COMPUTERS': ['computers', 'programming', 'software', 'hardware', 'internet', 'data'],
      'HISTORY': ['history', 'storia', 'historical', 'ancient'],
      'FICTION': ['fiction', 'novel', 'romanzo', 'literature'],
      'ART': ['art', 'painting', 'sculpture', 'fine arts'],
      'SCIENCE': ['science', 'physics', 'biology', 'chemistry', 'mathematics'],
      'RELIGION': ['religion', 'theology', 'church', 'spirituality'],
      'TRAVEL': ['travel', 'guide', 'voyage', 'turismo'],
    };

    for (var subject in subjects) {
      for (var entry in keywordMap.entries) {
        if (entry.value.any((keyword) => subject.contains(keyword))) {
          return entry.key; // Restituisce il nome esatto della tua lista (es. 'COOKING')
        }
      }
    }

    // Se non trova nulla di specifico, prova a vedere se il subject stesso contiene una parola della tua lista
    for (var category in BisacList.lstBisacCods) {
      String catLower = category.toLowerCase();
      if (subjects.any((s) => s.contains(catLower) || catLower.contains(s))) {
        return category;
      }
    }

    return "nonClassifiable";
  }

  String calcolaHash() {
    // Crea una mappa con i campi da considerare per l'hash
    final mapPerHash = {
      'googleBookId': googleBookId,
      'isbn': isbn.trim(),
      'titolo': titolo,
      'autori': lstAutori,
      'editore': editore,
      'descrizione': descrizione,
      'immagineCopertina': immagineCopertina,
      'dataPubblicazione': dataPubblicazione,
      'nrPagine': nrPagine,
      'lstCategoria': lstCategoria,
      'previewLink': previewLink,
      'typeBookSearch': typeBookSearch,
      'isEbook': isEbook,
      'country': country,
      'valuta': valuta,
      'prezzo': prezzo,
      'stars': stars,
      'pathImmagineCopertina': pathImmagineCopertina,
      'siglaLibreria': siglaLibreria,
      'note': note,
      // 'dataInserimento': dataInserimento,
      // 'dataUltimaModifica': dataUltimaModifica,
    };

    // Serializza in JSON con chiavi ordinate
    var jsonString = jsonEncode(Map.fromEntries(mapPerHash.entries.toList()..sort((a, b) => a.key.compareTo(b.key))));

    // Calcoli hash SHA256
    var bytes = utf8.encode(jsonString);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }

  String get normalizzaListaAutori {
    // 1. Applichiamo la normalizzazione a ogni singolo autore della lista
    List<String> autoriNormalizzati = lstAutori.map((autore) {
      // Rimuove accenti e minuscolo
      String pulita = Utils.rimuoviAccenti(autore.toLowerCase());

      // Divide per caratteri non alfanumerici e filtra i vuoti
      List<String> parti = pulita.split(RegExp(r'[^a-z0-9]'))
          .where((s) => s.isNotEmpty)
          .toList();

      // Ordina le parti del nome (es. "mario rossi" -> "mario rossi")
      parti.sort();

      return parti.join(' ');
    }).toList();

    // 2. Ordiniamo la lista degli autori stessi
    // (Fondamentale: così "Dante, Petrarca" e "Petrarca, Dante" diventano uguali)
    autoriNormalizzati.sort();

    // 3. Uniamo tutti gli autori in un'unica stringa identificativa
    return autoriNormalizzati.join(', ');
  }


  @override
  String toString() {
    return '''Libro.(
        isbn: $isbn; titolo: $titolo; autori: $lstAutori.toString(); editore: $editore; descrizione: $descrizione; immagineCopertina: $immagineCopertina;
        dataPubblicazione: $dataPubblicazione; nrPagine: $nrPagine; lstCategoria: $lstCategoria; previewLink: $previewLink; typeBookSearch: $typeBookSearch; isEbook: $isEbook; 
        country: $country; valuta: $valuta; prezzo: $prezzo; googleBookId: $googleBookId;''';
  }
}

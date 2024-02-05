import 'package:books/features/libro/data/models/libro_isar_search.module.dart';
import 'package:isar/isar.dart';
import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_search.module.dart';
import 'package:books/resources/bisac_codes.dart';
import 'dart:convert';

// part 'libro_isar_view.module.g.dart';

///** flutter pub run build_runner build */

@collection
class LibroIsarViewModel extends LibroIsarSearchModel {
  
  int stars;
  String? pathImmagineCopertina;  // Campo usato come 'backup' del campo 'immagineCopertina' originale
  String siglaLibreria; 
  String note;
  String dataInserimento;
  String dataUltimaModifica;

  LibroIsarViewModel(this.siglaLibreria, this.dataInserimento, this.dataUltimaModifica, {super.googleBookId='', required super.isbn, super.titolo='', super.lstAutori=const [], super.editore='', 
      super.descrizione='', super.immagineCopertina='', super.dataPubblicazione='', super.nrPagine=0, super.lstCategoria=const [], 
      super.previewLink='', super.isEbook=false, super.country='', super.valuta='',  super.prezzo='', this.stars = 0, this.pathImmagineCopertina, this.note = ''}) ;

  Map toJson() => {
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
    'isEbook': isEbook,
    'country': country, 
    'valuta': valuta,
    'prezzo': prezzo, 
    'googleBookId': googleBookId,
    'stars' : stars,
    'pathImmagineCopertina': pathImmagineCopertina,
    'siglaLibreria': siglaLibreria,
    'dataInserimento' : dataInserimento,
    'ultimaModifica' : dataUltimaModifica,
    'note': note
  };

  LibroIsarViewModel.fromMap(Map<String, dynamic> mappa, {
      this.stars = 0, 
      this.siglaLibreria = '', 
      this.dataInserimento = Constant.dataDefault, 
      this.dataUltimaModifica = Constant.dataDefault,
      this.note = ''}) {
    isbn = mappa['isbn'];
    titolo = mappa['titolo'];
    lstAutori = List<String>.from(jsonDecode(mappa['autori']));
    editore = mappa['editore'];
    descrizione = mappa['descrizione'];
    immagineCopertina = mappa['immagineCopertina'];
    dataPubblicazione = mappa['dataPubblicazione'];
    nrPagine = mappa['nrPagine'];
    lstCategoria = List<String>.from(jsonDecode(mappa['lstCategoria']));
    previewLink = mappa['previewLink'];
    isEbook = mappa['isEbook'];
    country = mappa['country'];
    valuta = mappa['valuta'];
    prezzo = mappa['prezzo'];
    googleBookId = mappa['id'] ?? mappa['googleBookId'];
    stars = mappa['stars'];
    pathImmagineCopertina = mappa['pathImmagineCopertina'];
    siglaLibreria = ComArea.libreriaInUso!.sigla;
  }

  LibroIsarViewModel copyWith({
      String? siglaLibreria,
      String? dataInserimento,
      String? dataUltimaModifica,
      String? note,
      String? googleBookId,
      String? isbn,
      String? titolo,
      List<String>? lstAutori,
      String? editore,
      String? descrizione,
      String? immagineCopertina,
      String? dataPubblicazione,
      int? nrPagine,
      List<String>? lstCategoria,
      String? previewLink,
      bool? isEbook,
      String? country,
      String? valuta,
      String? prezzo,  
      int? stars,
      String? pathImmagineCopertina
  }) => 
    LibroIsarViewModel(
        siglaLibreria ?? this.siglaLibreria,
        dataInserimento ?? this.dataInserimento,
        dataUltimaModifica ?? this.dataUltimaModifica,
        note: note ?? this.note,
        googleBookId: googleBookId ?? this.googleBookId,
        isbn: isbn ?? this.isbn, 
        titolo: titolo ?? this.titolo,
        lstAutori: lstAutori ?? this.lstAutori,
        editore: editore ?? this.editore,
        descrizione: descrizione ?? this.descrizione,
        immagineCopertina: immagineCopertina ?? this.immagineCopertina,
        dataPubblicazione: dataPubblicazione ?? this.dataPubblicazione,
        nrPagine: nrPagine ?? this.nrPagine,
        lstCategoria: lstCategoria ?? this.lstCategoria,
        previewLink: previewLink ?? this.previewLink,
        isEbook: isEbook ?? this.isEbook,
        country: country ?? this.country,
        valuta: valuta ?? this.valuta,
        prezzo: prezzo ?? this.prezzo,
        stars: stars ?? this.stars,
        pathImmagineCopertina: pathImmagineCopertina ?? this.pathImmagineCopertina,
    );

   LibroIsarViewModel clonaLibro() => LibroIsarViewModel(
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
        isEbook: isEbook,
        country: country,
        valuta: valuta,
        prezzo: prezzo,
        stars: stars,
        pathImmagineCopertina: pathImmagineCopertina,
    );

  /// Al salvataggio del Libro, dalla lista dei libri cercati:
  /// 
  loadDataFromLibroViewModel(LibroIsarViewModel libroViewModel) {
    googleBookId = libroViewModel.googleBookId;
    isbn = libroViewModel.isbn;
    country = libroViewModel.country;
    titolo = libroViewModel.titolo;
    editore = libroViewModel.editore;
    descrizione = libroViewModel.descrizione;
    immagineCopertina = libroViewModel.immagineCopertina;
    dataPubblicazione = libroViewModel.dataPubblicazione;
    previewLink = libroViewModel.previewLink;
    valuta = libroViewModel.valuta;
    prezzo = libroViewModel.prezzo;
    nrPagine = libroViewModel.nrPagine;
    lstCategoria = libroViewModel.lstCategoria;
    isEbook = libroViewModel.isEbook;
    lstAutori = libroViewModel.lstAutori;
    stars = libroViewModel.stars;
  }

  LibroIsarViewModel.fromGoogleMap(Map<String, dynamic> mappa, {
        this.stars = 0, 
        this.siglaLibreria = '', 
        this.dataInserimento = Constant.dataDefault, 
        this.dataUltimaModifica = Constant.dataDefault, 
        this.note = ''}) {
    googleBookId = mappa['id'] ?? mappa['googleBookId'];

    Map<String, dynamic> mapVolumeInfo = mappa['volumeInfo'];
    titolo = mapVolumeInfo['title'];
    if (mapVolumeInfo['authors'] != null) {
      lstAutori = (mapVolumeInfo['authors'] as List).map((item) => item as String).toList();
    } else {
      lstAutori = ['<Autore da definire>'];
    }
    descrizione = mapVolumeInfo['description'] ?? '';
    descrizione = descrizione.replaceAll('<i>', '');
    descrizione = descrizione.replaceAll('<br>', '');
    descrizione = descrizione.replaceAll('</i>', '');
    descrizione = descrizione.replaceAll('<b>', '');
    descrizione = descrizione.replaceAll('</b>', '');

    editore = mapVolumeInfo['publisher'] ?? Constant.editoreDaDefinire;

    List industryIdentifiers = mapVolumeInfo['industryIdentifiers'] ?? [];
    if (industryIdentifiers.isNotEmpty && industryIdentifiers.length > 1) {
      isbn = industryIdentifiers.elementAt(industryIdentifiers.length - 1)['identifier'];
    } else {
      isbn = '';
    }

    dataPubblicazione = mapVolumeInfo['publishedDate'] ?? '';
    nrPagine = mapVolumeInfo['pageCount'] ?? 0;
    
    if (mapVolumeInfo['categories'] != null) {
      lstCategoria = (mapVolumeInfo['categories'] as List).map((item) => item as String).toList();
      // if (lstCategoria.length > 1) {
      //   print('==============================================================> ${lstCategoria.toString()} <==========================================');
      // }
    } else {
      lstCategoria = [BisacList.nonClassifiable]; // mapVolumeInfo['categories'] ?? [];
    }

    previewLink = mapVolumeInfo['previewLink'] ?? '';

    try {
      immagineCopertina = mapVolumeInfo['imageLinks']['smallThumbnail'] ?? '';
      // immagineCopertina = "https://books.google.com/books/publisher/content/images/frontcover/${googleBookId}?fife=w400-h600&source=gbs_api";
      
      // if (immagineCopertina != '') {
      //   if (immagineCopertina.contains('zoom=1')) {
      //     immagineCopertina = immagineCopertina.replaceFirst('zoom=1', 'zoom=0');
      //   } else if (immagineCopertina.contains('zoom=5')) {
      //     immagineCopertina = immagineCopertina.replaceFirst('zoom=5', 'zoom=0');
      //   } else {
      //     immagineCopertina = immagineCopertina.replaceFirst('zoom=5', 'zoom=0');
      //   }
      // }
      // print("---------------------------------->$immagineCopertina");
    }
    catch (errore) {
      immagineCopertina = '';
    }

    Map<String, dynamic> saleInfo = mappa['saleInfo'] ?? {};
    isEbook = saleInfo['isEbook'] ?? false;
    country = saleInfo['country'] ?? '';
    
    valuta = '';
    prezzo = '';

    if (isEbook) {
      Map<String, dynamic> mapListPrice = saleInfo['listPrice'] ?? {};
      valuta = mapListPrice['currencyCode'] ?? '';
      prezzo = (mapListPrice['amount'] != null) ? mapListPrice['amount'].toString() : "0";
    }
  }
}
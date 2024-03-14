import 'dart:convert';

import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/link_isar.module.dart';
import 'package:books/features/libro/data/models/pdf_isar.module.dart';
import 'package:books/resources/bisac_codes.dart';
import 'package:books/utilities/utils.dart';
import 'package:isar/isar.dart';

part 'libro_isar.module.g.dart';

/// Modello like-GOOGLE-BOOK
/// 
///** flutter pub run build_runner build */

@Collection()
class LibroIsarModel  {
  Id id = Isar.autoIncrement;

  // Google-Book
  late String googleBookId;
  late String isbn;

  late String titolo;
  late String editore;

  @Index(composite: [CompositeIndex('titolo', caseSensitive: false), CompositeIndex('editore', caseSensitive: false)])
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

  // view
  late int stars;
  String? pathImmagineCopertina;  // Campo usato come 'backup' del campo 'immagineCopertina' originale
  late int siglaLibreria; 
  late String note;
  late String dataInserimento;
  late String dataUltimaModifica;
  
  final IsarLinks<LinkIsarModule> lstLinkIsarModule = IsarLinks<LinkIsarModule>();
  final IsarLinks<PdfIsarModule> lstPdfIsarModule = IsarLinks<PdfIsarModule>();

  LibroIsarModel(this.siglaLibreria, this.dataInserimento, this.dataUltimaModifica, 
    {this.googleBookId='', required this.isbn, this.titolo='', this.lstAutori=const [], this.editore='', this.descrizione='', 
    this.immagineCopertina='', this.dataPubblicazione='', this.nrPagine=0, this.lstCategoria=const [], this.previewLink='', 
    this.isEbook=false, this.country='', this.valuta='',  this.prezzo=0, this.stars = 0, this.pathImmagineCopertina, this.note = ''}) {
        if (lstCategoria.isEmpty) {
          lstCategoria = [BisacList.nonClassifiable];
        }
        if (prezzo < 0) {
          prezzo = 0;
        }
  }
 
  Map toJson() => {
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
    'isEbook': isEbook,
    'country': country, 
    'valuta': valuta,
    'prezzo': prezzo, 
    'stars' : stars,
    'pathImmagineCopertina': pathImmagineCopertina,
    'siglaLibreria': siglaLibreria,
    'note': note,
    'dataInserimento' : dataInserimento,
    'ultimaModifica' : dataUltimaModifica
  };
  
  LibroIsarModel.fromMap(Map<String, dynamic> mappa, {
      this.stars = 0, 
      this.siglaLibreria = 0, 
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
    lstCategoria = _getListaCategoriaFromMap(mappa['lstCategoria']);
    previewLink = mappa['previewLink'];
    isEbook = mappa['isEbook'];
    country = mappa['country'];
    valuta = mappa['valuta'];
    prezzo = (mappa['prezzo']  is double)
      ? mappa['prezzo']
      : Utils.getPositiveDouble(Utils.getTrimUppercaseParameter(mappa['prezzo']));
    googleBookId = mappa['id'] ?? mappa['googleBookId'];
    stars = mappa['stars'];
    pathImmagineCopertina = mappa['pathImmagineCopertina'];
    siglaLibreria = ComArea.libreriaInUso!.sigla;
    note = mappa['note'] ?? '';
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
    isEbook: isEbook,
    country: country,
    valuta: valuta,
    prezzo: prezzo,
    stars: stars,
    pathImmagineCopertina: pathImmagineCopertina
  );

  /// Al salvataggio del Libro, dalla lista dei libri cercati:
  /// 
  loadDataFromLibroViewModel(LibroIsarModel libroViewModel) {
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

  LibroIsarModel.fromGoogleMap(Map<String, dynamic> mappa, {
      this.stars = 0, 
      this.siglaLibreria = 0, 
      this.dataInserimento = Constant.dataDefault, 
      this.dataUltimaModifica = Constant.dataDefault, 
      this.note = ''}) {
    const String strNullValue = '';

    googleBookId = mappa['id'] ?? mappa['googleBookId'];

    Map<String, dynamic> mapVolumeInfo = mappa['volumeInfo'];
    titolo = mapVolumeInfo['title'];
    if (mapVolumeInfo['authors'] != null) {
      lstAutori = (mapVolumeInfo['authors'] as List).map((item) => item as String).toList();
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
      isbn = industryIdentifiers.elementAt(industryIdentifiers.length - 1)['identifier'];
    } else {
      isbn = '';
    }

    dataPubblicazione = mapVolumeInfo['publishedDate'] ?? strNullValue;
    nrPagine = mapVolumeInfo['pageCount'] ?? 0;
    
    if (mapVolumeInfo['categories'] != null) {
      lstCategoria = (mapVolumeInfo['categories'] as List).map((item) => item as String).toList();
      // if (lstCategoria.length > 1) {
      //   print('==============================================================> ${lstCategoria.toString()} <==========================================');
      // }
    } else {
      lstCategoria = [BisacList.nonClassifiable]; // mapVolumeInfo['categories'] ?? [];
    }

    previewLink = mapVolumeInfo['previewLink'] ?? strNullValue;

    try {
      immagineCopertina = mapVolumeInfo['imageLinks']['smallThumbnail'] ?? strNullValue;
    }
    catch (errore) {
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
      String strPrezzo = (mapListPrice['amount'] != null) ? mapListPrice['amount'].toString() : "0";
      if (double.tryParse(strPrezzo) != null) {
        prezzo = double.parse(strPrezzo);
      }
    }
  }

  @override
  String toString() {
    return '''Libro.(
        isbn: $isbn; titolo: $titolo; autori: $lstAutori.toString(); editore: $editore; descrizione: $descrizione; immagineCopertina: $immagineCopertina;
        dataPubblicazione: $dataPubblicazione; nrPagine: $nrPagine; lstCategoria: $lstCategoria; previewLink: $previewLink; isEbook: $isEbook; 
        country: $country; valuta: $valuta; prezzo: $prezzo; googleBookId: $googleBookId;''';
  }
  
}

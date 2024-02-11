import 'package:books/utilities/utils.dart';
import 'package:isar/isar.dart';
import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/resources/bisac_codes.dart';
import 'dart:convert';

part 'libro_isar.module.g.dart';

/// Modello like-GOOGLE-BOOK
/// 
///** flutter pub run build_runner build */

@collection
class LibroIsarModel  {
  Id id = Isar.autoIncrement;

  // Google-Book
  late String googleBookId;
  late String isbn;
  late String titolo;
  late List<String> lstAutori;
  late String editore;
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
  int stars;
  String? pathImmagineCopertina;  // Campo usato come 'backup' del campo 'immagineCopertina' originale
  int siglaLibreria; 
  String note;
  String dataInserimento;
  String dataUltimaModifica;

  LibroIsarModel(this.siglaLibreria, this.dataInserimento, this.dataUltimaModifica, 
    {this.googleBookId='', required this.isbn, this.titolo='', this.lstAutori=const [], this.editore='', 
      this.descrizione='', this.immagineCopertina='', this.dataPubblicazione='', this.nrPagine=0, this.lstCategoria=const [], 
      this.previewLink='', this.isEbook=false, this.country='', this.valuta='',  this.prezzo=0, this.stars = 0, this.pathImmagineCopertina, this.note = ''}) {
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
    note = mappa['note'];
  }

  List<String> _getListaCategoriaFromMap(dynamic lstCategoria) {
    if (lstCategoria != null) {
      return List<String>.from(jsonDecode(lstCategoria));
    }

    return [BisacList.nonClassifiable];
    
  }

  LibroIsarModel copyWith({
    int? siglaLibreria,
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
    double? prezzo,  
    int? stars,
    String? pathImmagineCopertina
  }) => 
    LibroIsarModel(
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
    pathImmagineCopertina: pathImmagineCopertina,
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

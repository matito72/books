import 'package:isar/isar.dart';

part 'libro_isar_search.module.g.dart';


/// Modello like-GOOGLE-BOOK
/// 
///** flutter pub run build_runner build */

@collection
class LibroIsarSearchModel  {
  Id id = Isar.autoIncrement;

  // Google-Book
  String googleBookId;
  String isbn;
  String titolo;
  List<String> lstAutori;
  String editore;
  String descrizione;
  String immagineCopertina;
  String dataPubblicazione;
  int nrPagine;
  List<String> lstCategoria;
  String previewLink;
  bool isEbook;
  String country;
  String valuta;
  String prezzo;

  LibroIsarSearchModel({this.googleBookId='', this.isbn='', this.titolo='', this.lstAutori=const [], this.editore='', this.descrizione='', this.immagineCopertina='',
      this.dataPubblicazione='', this.nrPagine=0, this.lstCategoria=const [], this.previewLink='', this.isEbook=false, this.country='',
      this.valuta='',  this.prezzo=''});
 
  @override
  String toString() {
    return '''Libro.(
        isbn: $isbn; titolo: $titolo; autori: $lstAutori.toString(); editore: $editore; descrizione: $descrizione; immagineCopertina: $immagineCopertina;
        dataPubblicazione: $dataPubblicazione; nrPagine: $nrPagine; lstCategoria: $lstCategoria; previewLink: $previewLink; isEbook: $isEbook; 
        country: $country; valuta: $valuta; prezzo: $prezzo; googleBookId: $googleBookId;''';
  }
}

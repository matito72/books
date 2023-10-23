import 'package:hive/hive.dart';

part 'libro_search_model.g.dart';

/// Modello like-GOOGLE-BOOK
/// 

@HiveType(typeId: 2)
class LibroSearchModel extends HiveObject {
  // Google-Book
  @HiveField(0)
  late String googleBookId;

  @HiveField(1)
  late String isbn;
  
  @HiveField(2)
  late String titolo;

  @HiveField(3)
  late List<String> lstAutori;

  @HiveField(4)
  late String editore;

  @HiveField(5)
  late String descrizione;

  @HiveField(6)
  late String immagineCopertina;

  // Google opzionale
  @HiveField(7)
  late String dataPubblicazione;

  @HiveField(8)
  late int nrPagine;

  @HiveField(9)
  late List<String> lstCategoria;

  @HiveField(10)
  late String previewLink;

  @HiveField(11)
  late bool isEbook;

  @HiveField(12)
  late String country;

  @HiveField(13)
  late String valuta;

  @HiveField(14)
  late String prezzo;  


  LibroSearchModel({this.googleBookId='', this.isbn='', this.titolo='', this.lstAutori=const [], this.editore='', this.descrizione='', this.immagineCopertina='',
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

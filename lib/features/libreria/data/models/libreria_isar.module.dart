import 'package:isar/isar.dart';

part 'libreria_isar.module.g.dart';

//** flutter pub run build_runner build */

@collection
class LibreriaIsarModel {
  Id sigla = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  String nome;

  int nrLibriCaricati;
  bool isLibreriaDefault;

  LibreriaIsarModel({this.nome = '-', this.nrLibriCaricati = 0, this.isLibreriaDefault = false});

}
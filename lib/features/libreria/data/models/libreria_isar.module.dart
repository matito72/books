import 'package:isar/isar.dart';

part 'libreria_isar.module.g.dart';

//** flutter pub run build_runner build */

@collection
class LibreriaIsarModel {
  Id sigla = Isar.autoIncrement;

  // String? sigla;
  String nome;
  int nrLibriCaricati;
  bool isLibreriaDefault;

  // LibreriaModelIsar({this.nome = '-', this.nrLibriCaricati = 0, this.isLibreriaDefault = false});

  // LibreriaModelIsar copyWith({
  //   String? nome,
  //   int? nrLibriCaricati,
  //   bool? isLibreriaDefault
  // }) =>
  //     LibreriaModelIsar(
  //       nome: nome ?? this.nome,
  //       nrLibriCaricati: nrLibriCaricati ?? this.nrLibriCaricati,
  //       isLibreriaDefault: isLibreriaDefault ?? this.isLibreriaDefault
  //     );

  LibreriaIsarModel({this.sigla = 0, this.nome = '-', this.nrLibriCaricati = 0, this.isLibreriaDefault = false});

  LibreriaIsarModel copyWith({
    int? sigla,
    String? nome,
    int? nrLibriCaricati,
    bool? isLibreriaDefault
  }) =>
      LibreriaIsarModel(
        sigla: sigla ?? this.sigla,
        nome: nome ?? this.nome,
        nrLibriCaricati: nrLibriCaricati ?? this.nrLibriCaricati,
        isLibreriaDefault: isLibreriaDefault ?? this.isLibreriaDefault
      );
}
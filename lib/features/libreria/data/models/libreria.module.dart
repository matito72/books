import 'package:hive/hive.dart';

part 'libreria.module.g.dart';

@HiveType(typeId: 1)
class LibreriaModel extends HiveObject {
  @HiveField(0)
  final String sigla;

  @HiveField(1)
  String nome;

  @HiveField(2)
  int nrLibriCaricati;

  @HiveField(3)
  bool isLibreriaDefault;

  LibreriaModel({this.sigla = '-', this.nome = '-', this.nrLibriCaricati = 0, this.isLibreriaDefault = false});

  // LibreriaModel copyWith({
  //   String? sigla,
  //   String? nome,
  //   int? nrLibriCaricati,
  //   bool? isLibreriaDefault
  // }) =>
  //     LibreriaModel(
  //       sigla: sigla ?? this.sigla,
  //       nome: nome ?? this.nome,
  //       nrLibriCaricati: nrLibriCaricati ?? this.nrLibriCaricati,
  //       isLibreriaDefault: isLibreriaDefault ?? this.isLibreriaDefault
  //     );

}
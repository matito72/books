import 'package:isar_community/isar.dart';

part 'pdf_isar.module.g.dart';

@Collection()
class PdfIsarModule {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;
  late String descrizione;
  late String testo;

  @Index(unique: true, caseSensitive: true)
  late String pathNameFile;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'descrizione': descrizione,
    'testo': testo,
    'pathNameFile': pathNameFile,
  };

  PdfIsarModule() {
    name = '';
    descrizione = '';
    testo = '';
    pathNameFile = '';
  }

  PdfIsarModule.fromMap(
      Map<String, dynamic> mappa, {
        name = '',
        descrizione = '',
        testo = '',
        pathNameFile = '',
      }) {
    name = mappa['name'];
    descrizione = mappa['descrizione'];
    testo = mappa['testo'];
    pathNameFile = mappa['pathNameFile'];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    // Controlla che 'other' sia dello stesso tipo e abbia gli stessi valori dei campi
    return other is PdfIsarModule &&
        other.name == name &&
        other.descrizione == descrizione &&
        other.testo == testo &&
        other.pathNameFile == pathNameFile;
  }

  @override
  int get hashCode {
    // Combina gli hash code dei campi per creare un hash unico
    return name.hashCode ^
        descrizione.hashCode ^
        testo.hashCode ^
        pathNameFile.hashCode;
  }
}
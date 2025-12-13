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
    // 'id': id,
    'name': name,
    'descrizione': descrizione,
    'testo': testo,
    'pathNameFile': pathNameFile,
  };

  PdfIsarModule({
    this.name = '',
    this.descrizione = '',
    this.testo = '',
    this.pathNameFile = ''
    // Non includere l'ID, Isar lo gestisce
  });

  PdfIsarModule.fromMap(Map<String, dynamic> mappa)
      : name = mappa['name'] as String,
        descrizione = mappa['descrizione'] as String,
        testo = mappa['testo'] as String,
        pathNameFile = mappa['pathNameFile'] as String {
    // Se la mappa contiene l'ID, assegnamolo (opzionale se l'oggetto viene sempre da Isar)
    if (mappa.containsKey('id')) {
      id = mappa['id'] as Id;
    }
  }

  PdfIsarModule clonaPdf() {
    return PdfIsarModule(
      name: name,
      descrizione: descrizione,
      testo: testo,
      pathNameFile: pathNameFile,
    );
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
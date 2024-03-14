import 'package:isar/isar.dart';

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
  
}
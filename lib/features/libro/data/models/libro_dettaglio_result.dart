import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/features/libro/data/models/link_isar.module.dart';
import 'package:books/features/libro/data/models/pdf_isar.module.dart';

class LibroDettaglioResult {
  LibroIsarModel libro;
  List<LinkIsarModule>? lstLinkIsarModule;
  List<PdfIsarModule>? lstPdfIsarModule;
  bool isInsert;
  bool isDelete;

  LibroDettaglioResult(this.libro, this.lstLinkIsarModule, this.lstPdfIsarModule, this.isInsert, this.isDelete);
}
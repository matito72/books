import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/features/libro/data/models/link_isar.module.dart';
import 'package:books/features/libro/data/models/pdf_isar.module.dart';

class LibroIsarToSaveModel {
  LibroIsarModel libroViewModel;
  List<LinkIsarModule>? lstLinkIsarModule;
  List<PdfIsarModule>? lstPdfIsarModule;
  int? siglaLibreriaOld; 
  String? isbnLibroOld; 

  LibroIsarToSaveModel(this.libroViewModel, {this.lstLinkIsarModule, this.lstPdfIsarModule, this.siglaLibreriaOld, this.isbnLibroOld});
}
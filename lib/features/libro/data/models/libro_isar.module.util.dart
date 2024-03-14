import 'package:books/features/libro/data/models/link_isar.module.dart';
import 'package:books/features/libro/data/models/pdf_isar.module.dart';

class LibroIsarModuleUtil {

  LibroIsarModuleUtil._();

  static LinkIsarModule createLinkIsarModule(
    String name, 
    String url, {
      String descrizione = ''
  }) {
    LinkIsarModule link = LinkIsarModule();
    link.name = name;
    link.url = url;
    link.descrizione = descrizione;

    return link;
  }

  static PdfIsarModule createPdfIsarModule(
    String name, 
    String pathNameFile, {
      String descrizione = '',
      String testo = ''
  }) {
    PdfIsarModule pdf = PdfIsarModule();
    pdf.name = name;
    pdf.pathNameFile = pathNameFile;
    pdf.descrizione = descrizione;
    pdf.testo = testo;

    return pdf;
  }
}
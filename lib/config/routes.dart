import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/features/libro/data/models/link_isar.module.dart';
import 'package:books/features/libro/data/models/pdf_isar.module.dart';
import 'package:books/models/parameter_google_search.module.dart';
import 'package:books/pages/dettaglio_libro.dart';
import 'package:books/pages/immagine_copertina.dart';
import 'package:books/pages/import_export_file.dart';
import 'package:books/screens/home_libreria.dart';
import 'package:books/screens/home_libri_libreria.dart';
import 'package:books/pages/search_list_book_page.dart';
import 'package:books/widgets/dettaglio_libro/image_to_pdf.dart';
import 'package:books/widgets/dettaglio_testo.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    final arguments = (settings.arguments ?? <String, dynamic>{}) as Map;

    switch (settings.name) {
      case '/':
        return _materialRoute(const HomeLibreriaScreen());

      case HomeLibriLibreriaScreen.screenPath:
        return _materialRoute(const HomeLibriLibreriaScreen()); 

      case SearchListBookPage.pagePath:
        final ParameterGoogleSearchModel googleSearchModel = arguments['googleSearchModel'];
        final LibreriaIsarModel libreriaSel = arguments['libreriaSel'];
        const String title = ' ';
        return _materialRoute(SearchListBookPage(title: title, googleSearchModel: googleSearchModel, libreriaSel: libreriaSel));

      case DettaglioLibro.pagePath:
        final LibroIsarModel libroViewModel = arguments['libroViewModel'];
        final List<LinkIsarModule> lstLinkIsarModule = arguments['lstLinkIsarModule'];
        final List<PdfIsarModule> lstPdfIsarModule = arguments['lstPdfIsarModule'];
        return _materialRoute(DettaglioLibro(libroViewModel: libroViewModel, lstLinkIsarModule: lstLinkIsarModule, lstPdfIsarModule: lstPdfIsarModule, showDelete: false));

      case DettaglioLibro.pageEditPath:
        final LibroIsarModel libroViewModel = arguments['libroViewModel'];
        final List<LinkIsarModule> lstLinkIsarModule = arguments['lstLinkIsarModule'];
        final List<PdfIsarModule> lstPdfIsarModule = arguments['lstPdfIsarModule'];
        return _materialRoute(DettaglioLibro(libroViewModel: libroViewModel, lstLinkIsarModule: lstLinkIsarModule, lstPdfIsarModule: lstPdfIsarModule, showDelete: true));

      case DettaglioLibro.pageNewBookPath:
        final LibroIsarModel libroViewModel = arguments['libroViewModel'];
        final List<LinkIsarModule> lstLinkIsarModule = arguments['lstLinkIsarModule'];
        final List<PdfIsarModule> lstPdfIsarModule = arguments['lstPdfIsarModule'];
        return _materialRoute(DettaglioLibro(libroViewModel: libroViewModel, lstLinkIsarModule: lstLinkIsarModule, lstPdfIsarModule: lstPdfIsarModule, showDelete: false, isInsertByUserInterface: true));

      case ImmagineCopertina.pagePath:
        final LibroIsarModel libroViewModel = arguments['libroViewModel'];
        return _materialRoute(ImmagineCopertina(libroViewModel: libroViewModel));

      case ImportExportFile.pagePath:
        return _materialRoute(const ImportExportFile());

      case ImageToPdf.pagePath:
        final LibroIsarModel libroViewModel = arguments['libroViewModel'];
        final List<PdfIsarModule> lstPdfIsarModule = arguments['lstPdfIsarModule'];
        final bool isCamera = arguments['isCamera'];
        final bool isGallery = arguments['isGallery'];
        return _materialRoute(ImageToPdf(libroViewModel: libroViewModel, lstPdfIsarModule: lstPdfIsarModule, isCamera: isCamera, isGallery: isGallery,));

      case DettaglioTesto.pagePath:
        final LibroIsarModel libroViewModel = arguments['libroViewModel'];
        final String testo = arguments['testo'];
        return _materialRoute(DettaglioTesto(libroViewModel: libroViewModel, testo: testo));

      default:
        return _materialRoute(const HomeLibreriaScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

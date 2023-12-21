import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/models/parameter_google_search.module.dart';
import 'package:books/pages/dettaglio_libro.dart';
import 'package:books/pages/immagine_copertina.dart';
import 'package:books/pages/import_export_file.dart';
import 'package:books/screens/home_libreria.dart';
import 'package:books/screens/home_libri_libreria.dart';
import 'package:books/pages/search_list_book_page.dart';
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
        final LibreriaModel libreriaSel = arguments['libreriaSel'];
        const String title = ' ';
        return _materialRoute(SearchListBookPage(title: title, googleSearchModel: googleSearchModel, libreriaSel: libreriaSel));

      case DettaglioLibro.pagePath:
        final LibroViewModel libroViewModel = arguments['libroViewModel'];
        return _materialRoute(DettaglioLibro(libroViewModel: libroViewModel, showDelete: false));

      case DettaglioLibro.pageEditPath:
        final LibroViewModel libroViewModel = arguments['libroViewModel'];
        return _materialRoute(DettaglioLibro(libroViewModel: libroViewModel, showDelete: true));

      case ImmagineCopertina.pagePath:
        final LibroViewModel libroViewModel = arguments['libroViewModel'];
        return _materialRoute(ImmagineCopertina(libroViewModel: libroViewModel));

      case ImportExportFile.pagePath:
        return _materialRoute(const ImportExportFile());

      default:
        return _materialRoute(const HomeLibreriaScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

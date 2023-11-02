import 'package:books/features/libreria/data/models/libreria_model.dart';
import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/features/libro/data/models/libro_search_model.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/pages/dettaglio_libro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';

abstract class LibroUtils {

  static String getStrLstAutoriRidotta(LibroSearchModel libroSearchModel, int max) {
    String strOut = libroSearchModel.lstAutori.join(', ');
    return strOut.length >= max ? '${strOut.substring(0, max)}...' : strOut;
  }

  //**
  static String getDataFormattata(String? strData) {
    if (strData == null || strData.isEmpty || strData.length < 4) {
      return '-';
    }

    String out = '';
    final DateFormat dfY = DateFormat("yyyy");

    try {
      if (strData.length > 10) {
        strData = strData.substring(0, 4);
      }

      if (strData.length == 4) {
        out = dfY.format(dfY.parse(strData));
      }
    } catch (e) {
      out = '-';
    }

    return out;
  }

  static viewDettaglioLibro(BuildContext context, LibreriaModel libreriaDefault, LibroSearchModel libroViewModel, bool showDelete) async {
    LibroDettaglioResult? ret = await Navigator.pushNamed(context, showDelete ? DettaglioLibro.pageEditPath : DettaglioLibro.pagePath, arguments: {
        'libroViewModel': libroViewModel
    }) as LibroDettaglioResult?;

    return ret;
  }

  static LibroViewModel createLibroViewFromSearchModel(LibreriaModel libreriaDefault, LibroSearchModel libroSearchModel) {
    LibroViewModel libroViewModel = LibroViewModel(libreriaDefault.sigla, 
      googleBookId: libroSearchModel.googleBookId,
      isbn: libroSearchModel.isbn,
      country: libroSearchModel.country, 
      titolo: libroSearchModel.titolo,
      editore: libroSearchModel.editore,
      descrizione: libroSearchModel.descrizione,
      immagineCopertina: libroSearchModel.immagineCopertina,
      dataPubblicazione: libroSearchModel.dataPubblicazione,
      previewLink: libroSearchModel.previewLink,
      valuta: libroSearchModel.valuta,
      prezzo: libroSearchModel.prezzo,
      nrPagine: libroSearchModel.nrPagine, 
      lstCategoria: libroSearchModel.lstCategoria, 
      isEbook: libroSearchModel.isEbook, 
      lstAutori: libroSearchModel.lstAutori,
    );
    
    return libroViewModel;
  }

  static LibroViewModel cloneLibroViewModel(LibroViewModel libroViewModel) {
    LibroViewModel cloneLibroViewModel = LibroViewModel(libroViewModel.siglaLibreria, 
      googleBookId: libroViewModel.googleBookId,
      isbn: libroViewModel.isbn,
      country: libroViewModel.country, 
      titolo: libroViewModel.titolo,
      editore: libroViewModel.editore,
      descrizione: libroViewModel.descrizione,
      immagineCopertina: libroViewModel.immagineCopertina,
      dataPubblicazione: libroViewModel.dataPubblicazione,
      previewLink: libroViewModel.previewLink,
      valuta: libroViewModel.valuta,
      prezzo: libroViewModel.prezzo,
      nrPagine: libroViewModel.nrPagine, 
      lstCategoria: libroViewModel.lstCategoria, 
      isEbook: libroViewModel.isEbook, 
      lstAutori: libroViewModel.lstAutori,
      stars: libroViewModel.stars
    );
    
    return cloneLibroViewModel;
  }
}

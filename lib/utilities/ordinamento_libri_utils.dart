import 'package:books/config/com_area.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/resources/libro_field_selected.dart';
import 'package:flutter/material.dart';

class OrdinamentoLibriUtils {

  static dynamic getLibroViewModelValue(LibroViewModel libroViewModel, LibroFieldSelected ordinamentoLibri) {
    return getLibroViewModelValueByLabel(libroViewModel, ordinamentoLibri.label);
  }

  static dynamic getLibroViewModelValueByLabel(LibroViewModel libroViewModel, String label) {
    if (label == LibroFieldSelected.titolo().label) {
      return libroViewModel.titolo;
    } else if (label == LibroFieldSelected.autore().label) {
      return libroViewModel.lstAutori.isNotEmpty ? libroViewModel.lstAutori[0] : '';
    } else if (label == LibroFieldSelected.editore().label) {
      return libroViewModel.editore;
    } else if (label == LibroFieldSelected.categoria().label) {
      return libroViewModel.lstCategoria[0];
    } else if (label == LibroFieldSelected.dtPubblicazione().label) {
      return libroViewModel.dataPubblicazione;
    } else if (label == LibroFieldSelected.prezzo().label) {
      double prezzo = 0;
      if (libroViewModel.prezzo.isNotEmpty) {
        try {
          prezzo = double.parse(libroViewModel.prezzo);
        } on Exception catch (e) {
          debugPrint('--->${libroViewModel.prezzo}<--- : $e');
        }
      }
      return prezzo;
    } else if (label == LibroFieldSelected.dtInserimento().label) {
      return libroViewModel.dataInserimento;
    } else if (label == LibroFieldSelected.dtUltimaModifica().label) {
      return libroViewModel.dataUltimaModifica;
    } else if (label == LibroFieldSelected.libreria().label) {
      return ComArea.mapCodDescLibreria[int.parse(libroViewModel.siglaLibreria)];
    } else if (label == LibroFieldSelected.isbn().label) {
       return libroViewModel.isbn;
    } else if (label == LibroFieldSelected.nrPagine().label) {
       return libroViewModel.nrPagine;
    }

    return "";
  } 
  
}
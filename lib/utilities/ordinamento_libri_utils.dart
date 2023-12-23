import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/resources/ordinamento_libri.dart';
import 'package:flutter/material.dart';

class OrdinamentoLibriUtils {

  static dynamic getLibroViewModelValue(LibroViewModel libroViewModel, OrdinamentoLibri ordinamentoLibri) {
    return getLibroViewModelValueByLabel(libroViewModel, ordinamentoLibri.label);
  }

  static dynamic getLibroViewModelValueByLabel(LibroViewModel libroViewModel, String label) {
    if (label == OrdinamentoLibri.titolo().label) {
      return libroViewModel.titolo;
    } else if (label == OrdinamentoLibri.autore().label) {
      return libroViewModel.lstAutori[0];
    } else if (label == OrdinamentoLibri.editore().label) {
      return libroViewModel.editore;
    } else if (label == OrdinamentoLibri.dtPubblicazione().label) {
      return libroViewModel.dataPubblicazione;
    } else if (label == OrdinamentoLibri.prezzo().label) {
      double prezzo = 0;
      if (libroViewModel.prezzo.isNotEmpty) {
        try {
          prezzo = double.parse(libroViewModel.prezzo);
        } on Exception catch (e) {
          debugPrint('--->${libroViewModel.prezzo}<--- : $e');
        }
      }
      return prezzo;
    }

    return "";
  }
  
}
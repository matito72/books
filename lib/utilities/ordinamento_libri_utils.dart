import 'package:book/config/com_area.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/resources/libro_field_selected.dart';

class OrdinamentoLibriUtils {

  static dynamic getLibroViewModelValue(LibroIsarModel libroViewModel, LibroFieldSelected ordinamentoLibri) {
    return getLibroViewModelValueByLabel(libroViewModel, ordinamentoLibri.label);
  }

  static dynamic getLibroViewModelValueByLabel(LibroIsarModel libroViewModel, String label) {
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
      double prezzo = libroViewModel.prezzo;
      return prezzo;
    } else if (label == LibroFieldSelected.dtInserimento().label) {
      return libroViewModel.dataInserimento;
    } else if (label == LibroFieldSelected.dtUltimaModifica().label) {
      return libroViewModel.dataUltimaModifica;
    } else if (label == LibroFieldSelected.libreria().label) {
      return ComArea.mapCodDescLibreria[libroViewModel.siglaLibreria];
    } else if (label == LibroFieldSelected.isbn().label) {
       return libroViewModel.isbn;
    } else if (label == LibroFieldSelected.nrPagine().label) {
       return libroViewModel.nrPagine;
    }

    return "";
  } 
  
}
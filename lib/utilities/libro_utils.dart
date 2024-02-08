import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/pages/dettaglio_libro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class LibroUtils {

  static String getStrLstAutoriRidotta(LibroIsarModel libroSearchModel, int max) {
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

      if (strData.length >= 4) {
        out = dfY.format(dfY.parse(strData));
      }
    } catch (e) {
      out = '-';
    }

    return out;
  }

  static viewDettaglioLibro(BuildContext context, LibreriaIsarModel libreriaIsarDefault, LibroIsarModel libroViewModel, bool showDelete, bool isInsertByUserInterface) async {
    LibroDettaglioResult? ret = await Navigator.pushNamed(
      context, 
      showDelete 
        ? DettaglioLibro.pageEditPath 
        : isInsertByUserInterface
          ? DettaglioLibro.pageNewBookPath
          : DettaglioLibro.pagePath, 
      arguments: {'libroViewModel': libroViewModel}
      ) as LibroDettaglioResult?;

    return ret;
  }

  static LibroIsarModel cloneLibroViewModel(LibroIsarModel libroViewModel) {
    LibroIsarModel cloneLibroViewModel = LibroIsarModel(
      libroViewModel.siglaLibreria, 
      libroViewModel.dataInserimento,
      libroViewModel.dataUltimaModifica,
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

  static addNrLibriCaricatiInCache(int siglaLibreria, {int nrToAdd = 1}) {
    for (LibreriaIsarModel libreriaIsarModel in ComArea.lstLibrerieInUso) {
      if (libreriaIsarModel.sigla == siglaLibreria) {
        libreriaIsarModel.nrLibriCaricati += nrToAdd;
        break;
      }
    }
  }

static removeNrLibriCaricatiInCache(int siglaLibreria) {
    for (LibreriaIsarModel libreriaIsarModel in ComArea.lstLibrerieInUso) {
      if (libreriaIsarModel.sigla == siglaLibreria) {
        libreriaIsarModel.nrLibriCaricati--;
        break;
      }
    }
  }

static clearNrLibriCaricatiInCache(int siglaLibreria) {
    for (LibreriaIsarModel libreriaIsarModel in ComArea.lstLibrerieInUso) {
      if (libreriaIsarModel.sigla == siglaLibreria) {
        libreriaIsarModel.nrLibriCaricati = 0;
        break;
      }
    }
  }
}

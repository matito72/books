import 'package:book/config/com_area.dart';
import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:book/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/link_isar.module.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/pages/dettaglio_libro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

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

  static Future<LibroDettaglioResult?>? viewDettaglioLibro(BuildContext context, 
      LibreriaIsarModel libreriaIsarDefault, 
      LibroIsarModel libroViewModel, 
      List<LinkIsarModule> lstLinks,
      List<PdfIsarModule> lstPdf,
      bool showDelete, 
      bool isInsertByUserInterface
  ) async {
    LibroDettaglioResult? ret = await Navigator.pushNamed(
      context, 
      showDelete 
        ? DettaglioLibro.pageEditPath 
        : isInsertByUserInterface
          ? DettaglioLibro.pageNewBookPath
          : DettaglioLibro.pagePath, 
      arguments: {'libroViewModel': libroViewModel, 'lstLinkIsarModule': lstLinks, 'lstPdfIsarModule': lstPdf}
      ) as LibroDettaglioResult?;

    return ret;
  }

  // static LibroIsarModel cloneLibroViewModel(LibroIsarModel libroViewModel) {
  //   LibroIsarModel cloneLibroViewModel = LibroIsarModel(
  //     libroViewModel.siglaLibreria, 
  //     libroViewModel.dataInserimento,
  //     libroViewModel.dataUltimaModifica,
  //     googleBookId: libroViewModel.googleBookId,
  //     isbn: libroViewModel.isbn,
  //     country: libroViewModel.country, 
  //     titolo: libroViewModel.titolo,
  //     editore: libroViewModel.editore,
  //     descrizione: libroViewModel.descrizione,
  //     immagineCopertina: libroViewModel.immagineCopertina,
  //     dataPubblicazione: libroViewModel.dataPubblicazione,
  //     previewLink: libroViewModel.previewLink,
  //     valuta: libroViewModel.valuta,
  //     prezzo: libroViewModel.prezzo,
  //     nrPagine: libroViewModel.nrPagine, 
  //     lstCategoria: libroViewModel.lstCategoria, 
  //     isEbook: libroViewModel.isEbook, 
  //     lstAutori: libroViewModel.lstAutori,
  //     stars: libroViewModel.stars
  //   );
    
  //   return cloneLibroViewModel;
  // }

  static void addNrLibriCaricatiInCache(int siglaLibreria, {int nrToAdd = 1}) {
    for (LibreriaIsarModel libreriaIsarModel in ComArea.lstLibrerieInUso) {
      if (libreriaIsarModel.sigla == siglaLibreria) {
        libreriaIsarModel.nrLibriCaricati += nrToAdd;
        break;
      }
    }
  }

  static void removeNrLibriCaricatiInCache(int siglaLibreria) {
    for (LibreriaIsarModel libreriaIsarModel in ComArea.lstLibrerieInUso) {
      if (libreriaIsarModel.sigla == siglaLibreria) {
        libreriaIsarModel.nrLibriCaricati--;
        break;
      }
    }
  }

  static void clearNrLibriCaricatiInCache(int siglaLibreria) {
    for (LibreriaIsarModel libreriaIsarModel in ComArea.lstLibrerieInUso) {
      if (libreriaIsarModel.sigla == siglaLibreria) {
        libreriaIsarModel.nrLibriCaricati = 0;
        break;
      }
    }
  }

  static bool areLinkIsarModuleListsEqual(List<LinkIsarModule> list1,
      List<LinkIsarModule> list2) {
    final equality = SetEquality<LinkIsarModule>();
    return equality.equals(list1.toSet(), list2.toSet());
  }

  static bool arePdfIsarModuleListsEqual(List<PdfIsarModule> list1,
      List<PdfIsarModule> list2) {
    final equality = SetEquality<PdfIsarModule>();
    return equality.equals(list1.toSet(), list2.toSet());
  }

}

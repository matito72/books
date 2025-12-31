

import 'dart:io';
import 'package:book/config/com_area.dart';
import 'package:excel/excel.dart';

import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path/path.dart' as p;

class ExportIntoExcelService {
  final String pathFolderRootDefault;
  final String pathFolderDefault;

  // Factory constructor che fa i calcoli
  factory ExportIntoExcelService(dynamic appDocumentDir) {
    final root = p.join(appDocumentDir.path, Constant.books);
    final folder = p.join(root, Constant.excelFilesPath);

    return ExportIntoExcelService._internal(root, folder);
  }

  // Costruttore privato
  ExportIntoExcelService._internal(this.pathFolderRootDefault, this.pathFolderDefault);

  Future<void> init() async {
    Directory dirRoot = Directory(pathFolderRootDefault);
    if (!await dirRoot.exists()) {
      await dirRoot.create();
    }

    Directory dir = Directory(pathFolderDefault);
    if (!await dir.exists()) {
      await dir.create();
    }
  }

  String get excelPathFolder => pathFolderDefault;

  Future<int> exportLibriInExcel(String prefixNomeFileExcel, List<LibroIsarModel> lstLibriLibreria) async {
    // final String pathFolder = pathFolderDefault;

    // 1. Check esistenza folder
    await init();

    // Crea l'oggetto Excel
    var excel = Excel.createExcel();

    // Rimuove il foglio di default (Sheet1) creato automaticamente
    excel.delete('Sheet1');

    Map<int, String> mapSigleDescLibreria = {};
    Map<int, Sheet> mapSigleSheet = {};
    List<String> headers = [
      'googleBookId', 'isbn', 'titolo', 'autori', 'editore',
      'descrizione', 'immagineCopertina', 'dataPubblicazione', 'nrPagine', 'lstCategoria',
      'previewLink', 'isEbook', 'country', 'valuta', 'prezzo',
      'stars', 'pathImmagineCopertina', 'siglaLibreria', 'note', 'dataInserimento',
      'ultimaModifica']; // , 'lstPdfIsarModule', 'lstLinkIsarModule'];

    for (LibroIsarModel libroIsarModel in lstLibriLibreria) {
      int key = libroIsarModel.siglaLibreria;
      String nomeLibreriaNew = ComArea.mapCodDescLibreria[key]!;

      if (!mapSigleDescLibreria.containsKey(key)) {
        Sheet sheet = excel[nomeLibreriaNew];
        mapSigleSheet[key] = sheet;

        // Aggiungi intestazioni
        mapSigleSheet[key]!.appendRow(headers.map((e) => TextCellValue(e)).toList());
      }

      mapSigleDescLibreria.putIfAbsent(key, () => nomeLibreriaNew);

      // Aggiungi la riga:
      // final List<Map<String, dynamic>> data = [libroIsarModel.toJson()];
      for ( var row in [libroIsarModel.toJsonExcel()] ) {
        mapSigleSheet[key]!.appendRow(
            headers.map((key) {
              var value = row[key] ?? "";

              if (value is List) return TextCellValue(value.join(", "));

              return TextCellValue(value.toString());
            }).toList()
        );
      }
    }

    // Salvataggio file:
    var fileBytes = excel.save();
    if (fileBytes != null) {
      // Otteniamo la directory del dispositivo (es. Documenti)
      String dtAttaule = DateFormat('yyyyMMdd').format(DateTime.now());
      final String filePath = "${excelPathFolder}/${prefixNomeFileExcel}_exportExcel_${dtAttaule}.xlsx";

      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);

      print("File salvato in: $filePath");

      // Suggerimento: usa share_plus per permettere all'utente di aprire il file
      // await Share.shareXFiles([XFile(filePath)], text: 'Ecco il tuo report!');
    }

    return 0;
  }

}

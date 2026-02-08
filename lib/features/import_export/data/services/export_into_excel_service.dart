import 'dart:io';
import 'package:book/config/com_area.dart';
import 'package:excel/excel.dart';

import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
// import 'package:share_plus/share_plus.dart';

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
    if (lstLibriLibreria.isEmpty) {
      return 0;
    }
    // final String pathFolder = pathFolderDefault;
    int nrLibriEsportati = 0;

    // 1. Check esistenza folder
    await init();

    // Crea l'oggetto Excel
    var excel = Excel.createExcel();

    Map<int, String> mapSigleDescLibreria = {};
    Map<int, Sheet> mapSigleSheet = {};
    CellStyle headerStyle = CellStyle(
      bold: true,
      italic: false,
      fontFamily: getFontFamily(FontFamily.Arial),
      backgroundColorHex: ExcelColor.blueAccent400, // Oppure usa un codice hex tipo "#ADD8E6"
      fontColorHex: ExcelColor.black,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );
    List<String> headers = [
      'googleBookId', 'isbn', 'titolo', 'autori', 'editore',
      'descrizione', 'immagineCopertina', 'dataPubblicazione', 'nrPagine', 'lstCategoria',
      'previewLink', 'isEbook', 'country', 'valuta', 'prezzo',
      'stars', 'pathImmagineCopertina', 'siglaLibreria', 'note', 'dataInserimento',
      'ultimaModifica']; // , 'lstPdfIsarModule', 'lstLinkIsarModule'];

    bool isSetDefaultSheet = false;
    for (LibroIsarModel libroIsarModel in lstLibriLibreria) {
      int key = libroIsarModel.siglaLibreria;
      String nomeLibreriaNew = ComArea.mapCodDescLibreria[key]!;

      if (!mapSigleDescLibreria.containsKey(key)) {
        Sheet sheet = excel[nomeLibreriaNew];
        mapSigleSheet[key] = sheet;

        // Aggiungi intestazioni
        // mapSigleSheet[key]!.appendRow(headers.map((e) => TextCellValue(e)).toList());

        for (var i = 0; i < headers.length; i++) {
          var cell = mapSigleSheet[key]!.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
          cell.value = TextCellValue(headers[i]);
          cell.cellStyle = headerStyle; // Applica lo stile qui
        }
      }

      mapSigleDescLibreria.putIfAbsent(key, () => nomeLibreriaNew);
      if (!isSetDefaultSheet) {
        excel.setDefaultSheet(nomeLibreriaNew);
      }

      // Aggiungi la riga:
      // final List<Map<String, dynamic>> data = [libroIsarModel.toJson()];
      for ( var row in [libroIsarModel.toJsonExcel()] ) {
        mapSigleSheet[key]!.appendRow(
            headers.map((key) {
              var value = row[key] ?? "";

              if (key == "prezzo") {
                return TextCellValue(value.toStringAsFixed(2));
              } else if (value is List) {
                return TextCellValue(value.join(", "));
              }

              return TextCellValue(value.toString());
            }).toList()
        );
        nrLibriEsportati++;
      }
    }

    // Rimuove il foglio di default (Sheet1) creato automaticamente
    excel.delete('Sheet1');

    // Salvataggio file:
    var fileBytes = excel.save();
    String  fileName;

    if (fileBytes != null) {
      // Otteniamo la directory del dispositivo (es. Documenti)
      String dtAttuale = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
      String lstSiglaDescLib = mapSigleDescLibreria.entries.map((e) => '${e.key}.${e.value}').join('_');
      fileName = "${prefixNomeFileExcel}_${nrLibriEsportati}_${lstSiglaDescLib}_${dtAttuale}.xlsx";
      if (fileName.length >= 255) {
        lstSiglaDescLib = mapSigleDescLibreria.entries.map((e) => '${e.key}').join('_');
        fileName = "${prefixNomeFileExcel}_${nrLibriEsportati}_${lstSiglaDescLib}_${dtAttuale}.xlsx";
      }
      String filePath = "$excelPathFolder/$fileName";

      File exportExcelFile = File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);

      print("File salvato in: $filePath");

      // final XFile xFile = XFile(exportExcelFile.path);
      // final params = ShareParams(
      //   files: [xFile], // Array di XFile
      //   text: 'Ecco il mio file di libreria.',
      //   title: fileName
      // );
      //
      // // Chiama il metodo 'share' sulla nuova istanza
      // final ShareResult result = await SharePlus.instance.share(params);

      await OpenFilex.open(exportExcelFile.path);
    }

    return nrLibriEsportati;
  }

}

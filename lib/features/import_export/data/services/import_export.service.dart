import 'dart:convert';
import 'dart:io';

import 'package:book/config/com_area.dart';
import 'package:book/config/constant.dart';
import 'package:book/features/import_export/bloc/import_export_state.bloc.dart';
import 'package:book/features/import_export/data/models/file_backup.module.dart';
import 'package:book/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/services/db_libro_isar.service.dart';
import 'package:book/injection_container.dart';
import 'package:book/models/libro_isar_to_save.module.dart';
import 'package:book/resources/item_exception.dart';
import 'package:book/utilities/libro_utils.dart';
import 'package:book/utilities/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
// import 'package:share_extend/share_extend.dart';
// import 'dart:io'; // Necessario per usare File
import 'package:path_provider/path_provider.dart' as path_provider;

class ImportExportService {
  final String pathFolderRootDefault;
  final String pathFolderDefault;

  // Factory constructor che fa i calcoli
  factory ImportExportService(dynamic appDocumentDir) {
    final root = p.join(appDocumentDir.path, Constant.books);
    final folder = p.join(root, Constant.jsonFilesPath);

    return ImportExportService._internal(root, folder);
  }

  // Costruttore privato
  ImportExportService._internal(this.pathFolderRootDefault, this.pathFolderDefault);

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

  // void checkCreateDirectory(String pathFolder) async {
  //   Directory directory =  Directory(pathFolder);
  //   if (!await directory.exists()) {
  //     Directory d = await directory.create(recursive: true);
  //     print('${d.absolute} : ${d.path}');
  //   }
  // }

  Future<List<FileBackupModel>> copiaFile(String pathFolderFileSorgente, String nomeFileSorgente, int siglaLibreria) async {
    List<LibroIsarModel> lstLibroViewModel = await restoreFileBackup(pathFolderFileSorgente, nomeFileSorgente);
    int nrLibri = lstLibroViewModel.length;
    String nomeFileDestinazione = _getNomeFile('libreria', siglaLibreria.toString(), nrLibri);

    bool ok = await Utils.copiaFile(
        pathFolderFileSorgente: pathFolderFileSorgente, nomeFileSorgente: nomeFileSorgente,
        pathFolderDestinazione: pathFolderDefault, nomeFileDestinazione: nomeFileDestinazione);
    List<FileBackupModel> lstFileBackupView = [];
    if (ok) {
      lstFileBackupView = await getListImportExportFile(
          filterWhere: '_${siglaLibreria}_',
          printDebug: true
      );
    }

    // String msg = lstFileBackupView.isEmpty ? 'Nessun file di backup presente' : 'Nr. ${lstFileBackupView.length}, file caricati correttamente';
    return lstFileBackupView;
  }

  Future<int> exportLibriLibreria(String prefixNomeBackup, String siglaLibreria, List<LibroIsarModel> lstLibriLibreria) async {
    final String pathFolder = pathFolderDefault;

    // Check esistenza folder
    await init();
    // checkCreateDirectory(pathFolder);

    // Write file json (overwrite di default)
    final File file = File(
      p.join(
        pathFolder,
        _getNomeFile(prefixNomeBackup, siglaLibreria, lstLibriLibreria.length),
      ),
    );
    await file.writeAsString(json.encode(lstLibriLibreria));

    return lstLibriLibreria.length;
    // // TEST
    // await getListImportExportFile(printDebug: true);
  }

  ///
  /// Restituisce una lista di 'LibroViewModel' a fronte di un file json
  ///
  Future<List<LibroIsarModel>> restoreFileBackup(
    String? pathFolderFile,
    String nomeFile,
  ) async {
    List<LibroIsarModel> lstLibriLibreria = [];

    final String pathFolder = pathFolderFile ?? pathFolderDefault;
    final File file = File('$pathFolder/$nomeFile');

    String jsonFile = await file.readAsString();
    List<dynamic> lstJsonEntities = await json.decode(jsonFile);
    for (var json in lstJsonEntities) {
      lstLibriLibreria.add(LibroIsarModel.fromMap(json));
    }

    return lstLibriLibreria;
  }

  Future<ImportedFileBackupState> importIntoDbFileBackup(String? pathFolderFile, String nomeFile) async {
    List<LibroIsarModel> lstLibroViewModel = await restoreFileBackup(
      pathFolderFile,
      nomeFile,
    );
    int nrLibriCaricati = 0;

    if (lstLibroViewModel.isNotEmpty) {
      DbLibroIsarService dbLibroService = sl<DbLibroIsarService>();
      DbLibreriaIsarService dbLibreriaService = sl<DbLibreriaIsarService>();

      int siglaLibreria = ComArea.libreriaInUso!.sigla;
      List<LibroIsarModel> lstLibriGiaPresenti = [];
      Object? errore;

      for (var libroModelNew in lstLibroViewModel) {
        libroModelNew.siglaLibreria = siglaLibreria;
        libroModelNew.dataInserimento = Utils.getDataNow();
        libroModelNew.dataUltimaModifica = Utils.getDataNow();

        LibroIsarToSaveModel libroIsarToSaveModel = LibroIsarToSaveModel(libroModelNew);

        try {
          LibroIsarModel? libroDb =  await dbLibroService.getLibroBySiglaLibreriaAndIsbn(siglaLibreria, libroIsarToSaveModel.libroViewModel.isbn);
          if (libroDb != null) {
            lstLibriGiaPresenti.add(libroModelNew);
            continue;
          }

          if (libroModelNew.lstPdfModule.isNotEmpty) {
            libroIsarToSaveModel.libroViewModel.lstPdfIsarModule.addAll(libroModelNew.lstPdfIsarModule);
            libroIsarToSaveModel.lstPdfIsarModule = libroModelNew.lstPdfModule;
          }
          if (libroModelNew.lstLinkModule.isNotEmpty) {
            libroIsarToSaveModel.libroViewModel.lstLinkIsarModule.addAll(libroModelNew.lstLinkIsarModule);
            libroIsarToSaveModel.lstLinkIsarModule = libroModelNew.lstLinkModule;
          }
          await dbLibroService.saveLibroToDb(libroIsarToSaveModel, true);

          nrLibriCaricati++;
        } on ItemPresentException {
          lstLibriGiaPresenti.add(libroModelNew);
        } catch (e) {
          errore = e;
          break;
        }
      }

      await dbLibreriaService.addLibriInLibreriaInUso(
        ComArea.libreriaInUso!.sigla,
        nrLibriCaricati,
      );
      LibroUtils.addNrLibriCaricatiInCache(
        ComArea.libreriaInUso!.sigla,
        nrToAdd: nrLibriCaricati,
      );
      if (errore != null) {
        throw errore;
      }
      // print('lstLibriGiaPresenti: ${lstLibriGiaPresenti.length}');
    }

    return ImportedFileBackupState(
      lstLibroViewModel.length,
      'Importati $nrLibriCaricati libri.',
    );
  }

  Future<void> shareFileBackup(FileBackupModel fileBackupModel) async {
    final String pathFolder = pathFolderDefault;
    final File file = File('$pathFolder/${fileBackupModel.fileName}');

    // ShareExtend.share(file.path, "file");

    final xFile = XFile(file.path);
    // Crea i parametri di condivisione
    final params = ShareParams(
      files: [xFile], // Array di XFile
      text: 'Ecco il mio file di libreria.', // Testo opzionale da allegare
      // Aggiungi qui altre opzioni come 'subject' o 'title'
    );

    // Chiama il metodo 'share' sulla nuova istanza
    final ShareResult result = await SharePlus.instance.share(params);

    // Puoi anche gestire il risultato della condivisione (opzionale)
    if (result.status == ShareResultStatus.success) {
      debugPrint('Condivisione avvenuta con successo!');
    }

    // Share.shareFile(File('/screenshot.png'),
    //     subject: 'Share ScreenShot',
    //     text: 'Hello, check your share files!',
    //     // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
    // );
  }

  Future<File> fileRename(String pathNameFile, String newFileName) async {
    File file = File(pathNameFile);
    // var path = file.path;
    // var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    // var newPath = '${path.substring(0, lastSeparator + 1)}libreria_8_TT_20230731.json';
    return await file.rename(newFileName);
  }

  Future<FileSystemEntity?> eliminaFile(
    FileBackupModel fileBackupModelDelete,
  ) async {
    FileSystemEntity? fileSystemEntity;
    final String pathFolder = pathFolderDefault;
    final File file = File('$pathFolder/${fileBackupModelDelete.fileName}');
    if (await file.exists()) {
      fileSystemEntity = await file.delete();
    }

    return fileSystemEntity;
  }

  Future<List<FileBackupModel>> getListImportExportFile({
    String? pathFolder,
    String? filterWhere,
    bool? printDebug,
  }) async {
    List<FileBackupModel> lstFileBackup = [];
    List<FileSystemEntity> entities = await Directory(
      pathFolder ?? pathFolderDefault,
    ).list().toList();

    if (entities.isNotEmpty) {
      if (filterWhere != null) {
        entities = entities
            .where(
              (fse) => fse.toString().toLowerCase().contains(
                filterWhere.toLowerCase(),
              ),
            )
            .toList(growable: true);
      }
      for (var element in entities) {
        // <prefisso_nome_file>_<nr_record>_<siglaLibreria>_<yyyyMMdd>.json
        String fileName = element.path.substring(element.path.lastIndexOf(Platform.pathSeparator) + 1);
        List<String> lstSegmentFileName = fileName.split("_");

        FileStat fileStat = await element.stat();
        lstFileBackup.add(
          FileBackupModel(
            siglaLibreria: int.parse(lstSegmentFileName[2]),
            fileName: fileName,
            nrRecord: int.parse(lstSegmentFileName[1]),
            dtUltimaModifica: fileStat.changed,
            fileSize: fileStat.size,
          ),
        );
        lstFileBackup.sort((a, b) {
          return b.dtUltimaModifica.compareTo(a.dtUltimaModifica);
        });

        if (printDebug != null && printDebug) {
          debugPrint(
            '${element.absolute} : ${element.isAbsolute} : ${element.path} : $fileStat',
          );
        }
      }
    }

    return lstFileBackup;
  }

  // <prefisso_nome_file>_<nr_record>_<siglaLibreria>_<yyyyMMdd>.json
  String _getNomeFile(String prefixNomeBackup, String siglaLibreria, int nrLibri) {
    String dtAttaule = DateFormat('yyyyMMdd').format(DateTime.now());
    return '${prefixNomeBackup}_${nrLibri}_${siglaLibreria}_$dtAttaule.json';
  }
}

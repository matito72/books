import 'dart:convert';
import 'dart:io';
import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/import_export/bloc/import_export_state.bloc.dart';
import 'package:books/features/import_export/data/models/file_backup.module.dart';
import 'package:books/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/features/libro/data/services/db_libro_isar.service.dart';
import 'package:books/injection_container.dart';
import 'package:books/models/libro_isar_to_save.module.dart';
import 'package:books/resources/item_exception.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:share_extend/share_extend.dart';

class ImportExportService {

  final String pathFolderDefault;

  ImportExportService(appDocumentDir) : pathFolderDefault = p.join(appDocumentDir.path, Constant.jsonFilesPath);

  Future<void> init() async {
    Directory dir = Directory(pathFolderDefault);
    if (! await dir.exists()) {
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

  Future<int> exportLibriLibreria(String prefixNomeBackup, String siglaLibreria, List<LibroIsarModel> lstLibriLibreria) async {
    final String pathFolder = pathFolderDefault;

    // Check esistenza folder
    await init();
    // checkCreateDirectory(pathFolder);

    // Write file json (overwrite di default)
    final File file = File(p.join(pathFolder, _getNomeFile(prefixNomeBackup, siglaLibreria, lstLibriLibreria.length)));
    await file.writeAsString(json.encode(lstLibriLibreria));

    return lstLibriLibreria.length;
    // // TEST
    // await getListImportExportFile(printDebug: true);
  }

  /// 
  /// Restituisce una lista di 'LibroViewModel' a fronte di un file json
  ///
  Future<List<LibroIsarModel>> restoreFileBackup(String? pathFolderFile, String nomeFile) async {
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
    List<LibroIsarModel> lstLibroViewModel = await restoreFileBackup(pathFolderFile, nomeFile);
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

        try {
          await dbLibroService.saveLibroToDb(LibroIsarToSaveModel(libroModelNew), true);
          nrLibriCaricati++;
        } on ItemPresentException {
          lstLibriGiaPresenti.add(libroModelNew);
        } catch (e) {
          errore = e;
          break;
        }
      }

      await dbLibreriaService.addLibriInLibreriaInUso(ComArea.libreriaInUso!.sigla, nrLibriCaricati);
      LibroUtils.addNrLibriCaricatiInCache(ComArea.libreriaInUso!.sigla, nrToAdd: nrLibriCaricati);
      if (errore != null) {
        throw errore;
      }
      // print('lstLibriGiaPresenti: ${lstLibriGiaPresenti.length}');
    }

    return ImportedFileBackupState(lstLibroViewModel.length, 'Importati $nrLibriCaricati libri.');
  }

  Future<void> shareFileBackup(FileBackupModel fileBackupModel) async {
    final String pathFolder = pathFolderDefault;
    final File file = File('$pathFolder/${fileBackupModel.fileName}');

    ShareExtend.share(file.path, "file");
    
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

  Future<FileSystemEntity?> eliminaFile(FileBackupModel fileBackupModelDelete) async {
    FileSystemEntity? fileSystemEntity;
    final String pathFolder = pathFolderDefault;
    final File file = File('$pathFolder/${fileBackupModelDelete.fileName}');
    if (await file.exists()) {
      fileSystemEntity = await file.delete();
    }

    return fileSystemEntity;
  }

  Future<List<FileBackupModel>> getListImportExportFile({String? pathFolder, String? filterWhere, bool? printDebug}) async {
    List<FileBackupModel> lstFileBackup = [];
    List<FileSystemEntity> entities = await Directory(pathFolder ?? pathFolderDefault).list().toList();    

    if (entities.isNotEmpty) {
      if (filterWhere != null) {
        entities = entities.where((fse) => fse.toString().toLowerCase().contains(filterWhere.toLowerCase())).toList(growable: true);
      }
      for (var element in entities) {
        // <prefisso_nome_file>_<nr_record>_<siglaLibreria>_<yyyyMMdd>.json
        String fileName = element.path.substring(element.path.lastIndexOf(Platform.pathSeparator) + 1); 
        List<String> lstSegmentFileName = fileName.split("_");

        FileStat fileStat = await element.stat();
        lstFileBackup.add(FileBackupModel(
          siglaLibreria: int.parse(lstSegmentFileName[2]),
          fileName: fileName,
          nrRecord: int.parse(lstSegmentFileName[1]),
          dtUltimaModifica: fileStat.changed,
          fileSize: fileStat.size));
        
        if (printDebug != null && printDebug) {
          debugPrint('${element.absolute} : ${element.isAbsolute} : ${element.path} : $fileStat');
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
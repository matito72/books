import 'dart:io';

import 'package:books/config/constant.dart';
import 'package:books/features/import_export/blocs/import_export_events.dart';
import 'package:books/features/import_export/blocs/import_export_state.dart';
import 'package:books/features/import_export/data/models/file_backup.dart';
import 'package:books/features/import_export/data/repository/import_export_service.dart';
import 'package:books/features/libreria/data/repository/db_libreria_service.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/features/libro/data/repository/db_libro_service.dart';
import 'package:books/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImportExportBloc extends Bloc<ImportExportEvent, ImportExportState> {
  final ImportExportService _importExportService;

  ImportExportBloc(this._importExportService) : super(const ImportExportWaitingState()) {
    
    // ** INIT
    on<InitImportExportEvent>((event, emit) async {
      emit(const ImportExportWaitingState());
      try {
        await _importExportService.init();
        emit(const ImportExportInitializedState("Init DB"));
      } catch (e) {
        emit(ImportExportErrorState(e.toString()));
      }
    });

    // ** LOAD LIST FILE BACKUP
    on<LoadFileBackupEvent>((event, emit) async {
      emit(const ImportExportWaitingState());
      try {
        List<FileBackupModel> lstFileBackupView = await _importExportService.getListImportExportFile(
          filterWhere: '_${event.siglaLibreria}_',
          printDebug: true
        );
        String msg = lstFileBackupView.isEmpty ? 'Nessun file di backup presente' : 'Nr. ${lstFileBackupView.length}, file caricati correttamente';
        emit(ListaFileBackupLoadedState(lstFileBackupView, msg));
      } catch (e) {
        emit(ImportExportErrorState(e.toString()));
      }
    });

    // // ** EXPORT: add file backup
    // on<AddFileBackupEvent>((event, emit) async {
    //   emit(const ImportExportWaitingState());
    //   try {
    //     await _importExportService.exportLibriLibreria(event.prefixNomeBackup, event.siglaLibreria, event.lstLibriLibreria);
        
    //     emit(ExportedFileBackupState(event.lstLibriLibreria.length, 'Esportati ${event.lstLibriLibreria.length} libri.'));
    //   } catch (e) {
    //     emit(ImportExportErrorState(e.toString()));
    //   }
    // });

    // ** DELETE:  file backup
    on<DeleteFileBackupEvent>((event, emit) async {
      emit(const ImportExportWaitingState());
      try {
        FileSystemEntity? file = await _importExportService.eliminaFile(event.fileBackupModelDelete);
        String msg = file != null ? 'eliminato' : "non eliminato";
        emit(DeletedFileBackupState('File ${event.fileBackupModelDelete.fileName} $msg.'));
      } catch (e) {
        emit(ImportExportErrorState(e.toString()));
      }
    });

    // ** IMPORT: import file backup into libreria selezionata
    on<ImportFileBackupEvent>((event, emit) async {
      emit(const ImportExportWaitingState());
      try {
        List<LibroViewModel> lstLibroViewModel = await _importExportService.restoreFileBackup(event.pathFolderFile, event.fileBackupModel.fileName);
        
        if (lstLibroViewModel.isNotEmpty) {
          DbLibroService dbLibroService = sl<DbLibroService>();
          DbLibreriaService dbLibreriaService = sl<DbLibreriaService>();

          String siglaLibreria = Constant.libreriaInUso!.sigla;
          for (var libroModelNew in lstLibroViewModel) {
            libroModelNew.siglaLibreria = siglaLibreria;
            await dbLibroService.saveLibroToDb(libroModelNew, true);            
            await dbLibreriaService.addLibriInLibreriaInUso(1);
          }
        }

        emit(ImportedFileBackupState(lstLibroViewModel.length, 'Importati ${lstLibroViewModel.length} libri.'));
      } catch (e) {
        emit(ImportExportErrorState(e.toString()));
      }
    });

  }
}
import 'dart:io';

import 'package:books/features/import_export/bloc/import_export_events.bloc.dart';
import 'package:books/features/import_export/bloc/import_export_state.bloc.dart';
import 'package:books/features/import_export/data/models/file_backup.module.dart';
import 'package:books/features/import_export/data/services/import_export.service.dart';
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

    // // ** IMPORT: import file backup into libreria selezionata
    // on<ImportFileBackupEvent>((event, emit) async {
    //   emit(const ImportExportWaitingState());
    //   try {
    //     ImportedFileBackupState importedFileBackupState = await _importExportService.importIntoDbFileBackup(event.pathFolderFile, event.fileBackupModel.fileName);
    //     emit(importedFileBackupState);
    //   } catch (e) {
    //     emit(ImportExportErrorState(e.toString()));
    //   }
    // });

  }
}
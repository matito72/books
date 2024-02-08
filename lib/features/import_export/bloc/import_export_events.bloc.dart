import 'package:books/features/import_export/data/models/file_backup.module.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ImportExportEvent extends Equatable {
  const ImportExportEvent();

  @override
  List<Object?> get props => [];
}

//* INIT
class InitImportExportEvent extends ImportExportEvent { }

//* DISPOSE
class DisposeLibroEvent extends ImportExportEvent { }

//* LIST
class LoadFileBackupEvent extends ImportExportEvent { 
  final int siglaLibreria;

  const LoadFileBackupEvent(this.siglaLibreria);
}

// //* BACKUP ALL LIBRI LIBRERIA
// class AddFileBackupEvent extends ImportExportEvent {
//   final String prefixNomeBackup;
//   final String siglaLibreria;
//   final List<LibroViewModel> lstLibriLibreria;

//   const AddFileBackupEvent(this.prefixNomeBackup, this.siglaLibreria, this.lstLibriLibreria);
// }

//* IMPORT FILE BACKUP INTO LIBRERIA
class ImportFileBackupEvent extends ImportExportEvent {
  final String? pathFolderFile;
  final FileBackupModel fileBackupModel;

  const ImportFileBackupEvent(this.pathFolderFile, this.fileBackupModel);
}

//* BACKUP LISTA LIBRI LIBRERIA
class AddListaFileBackupEvent extends ImportExportEvent {
  final String siglaLibreria;
  final List<LibroIsarModel> lstLibroViewModel;

  const AddListaFileBackupEvent(this.siglaLibreria, this.lstLibroViewModel);
}

//* DEL FILE
class DeleteFileBackupEvent extends ImportExportEvent {
  final FileBackupModel fileBackupModelDelete;

  const DeleteFileBackupEvent(this.fileBackupModelDelete);
}
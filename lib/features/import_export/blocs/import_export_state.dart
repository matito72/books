import 'package:books/features/import_export/data/models/file_backup.dart';
import 'package:books/resources/action_result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ImportExportState<T> extends Equatable {
  final T ? data;
  final String? msg;
  final ActionResult? actionResult;

  const ImportExportState({this.data, this.msg, this.actionResult});

  @override
  List<Object?> get props => [data, msg, actionResult];
}

//* SUCCESS
abstract class ImportExportSuccessState<T> extends ImportExportState {
  const ImportExportSuccessState({T? data, String? msg}) : super(data: data, msg: msg, actionResult: ActionResult.success);
}

//* ERRORE
class ImportExportErrorState extends ImportExportState {
  const ImportExportErrorState(String msg) : super(msg: msg, actionResult: ActionResult.failure);
}

//* WAIT
class ImportExportWaitingState extends ImportExportSuccessState {
  const ImportExportWaitingState();
}

//* INIT
class ImportExportInitializedState extends ImportExportSuccessState {
  const ImportExportInitializedState(String msg) : super(msg: msg);
}

//* LISTA
class ListaFileBackupLoadedState<T extends List<FileBackupModel>> extends ImportExportSuccessState {
  const ListaFileBackupLoadedState(List<FileBackupModel> data, String msg) : super(data: data, msg: msg);
}

//* DELETE FILE ESPORTATO
class DeletedFileBackupState<int> extends ImportExportSuccessState {
  const DeletedFileBackupState(String msg) : super(msg: msg);
}

//* DELETE ALL
class DeleteAllFileBackupState<int> extends ImportExportSuccessState {
  const DeleteAllFileBackupState(int data, String msg) : super(data: data, msg: msg);
}

//* EXPORTED FILE
class ExportedFileBackupState<int> extends ImportExportSuccessState {
  const ExportedFileBackupState(int data, String msg) : super(data: data, msg: msg);
}

//* IMPORTED FILE
class ImportedFileBackupState<int> extends ImportExportSuccessState {
  const ImportedFileBackupState(int data, String msg) : super(data: data, msg: msg);
}
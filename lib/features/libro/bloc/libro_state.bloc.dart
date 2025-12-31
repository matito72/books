import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/models/selected_item.module.dart';
import 'package:book/resources/action_result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LibroState<T> extends Equatable {
  final T? data;
  final String? msg;
  final ActionResult? actionResult;

  const LibroState({this.data, this.msg, this.actionResult});

  @override
  List<Object?> get props => [data, msg, actionResult];
}

//* SUCCESS
abstract class LibroSuccessState<T> extends LibroState {
  const LibroSuccessState({T? super.data, super.msg})
    : super(actionResult: ActionResult.success);
}

//* WAIT
class LibroWaitingState extends LibroSuccessState {
  const LibroWaitingState();
}

//* INIT
class LibroInitializedState extends LibroSuccessState {
  const LibroInitializedState(String msg) : super(msg: msg);
}

//* LISTA
class ListaLibroLoadedState<T extends List<SelectedItem<LibroIsarModel>>>
    extends LibroSuccessState {
  const ListaLibroLoadedState(
    List<SelectedItem<LibroIsarModel>> data,
    String msg,
  ) : super(data: data, msg: msg);
}

//* ADDED NEW LIBRO
class AddedNewLibroState extends LibroSuccessState {
  const AddedNewLibroState(String msg) : super(msg: msg);
}

//* EXPORTED FILE
class ExportedFileState<T extends int> extends LibroSuccessState {
  const ExportedFileState(int data, String msg) : super(data: data, msg: msg);
}

//* EXPORTED FILE EXCEL
class ExportedFileExcelState<T extends int> extends LibroSuccessState {
  const ExportedFileExcelState(int data, String msg) : super(data: data, msg: msg);
}

//* IMPORTED FILE
class ImportedFileState<T extends int> extends LibroSuccessState {
  const ImportedFileState(int data, String msg) : super(data: data, msg: msg);
}

//* EDIT LIBRO
class EditLibroState extends LibroSuccessState {
  const EditLibroState(String msg) : super(msg: msg);
}

//* DELETE LIBRO
class DeletedLibroState<T extends int> extends LibroSuccessState {
  const DeletedLibroState(String msg) : super(msg: msg);
}

//* DELETE ALL
class DeleteAllLibroState<T extends int> extends LibroSuccessState {
  const DeleteAllLibroState(int data, String msg) : super(data: data, msg: msg);
}

class DeleteBookSelectedState<T extends int> extends LibroSuccessState {
  const DeleteBookSelectedState(int data, String msg)
    : super(data: data, msg: msg);
}

class CambiaLibreriaBookSelectedState<T extends int> extends LibroSuccessState {
  const CambiaLibreriaBookSelectedState(int data, String msg)
      : super(data: data, msg: msg);
}

//* ERRORE
class LibroErrorState extends LibroState {
  const LibroErrorState(String msg)
    : super(msg: msg, actionResult: ActionResult.failure);
}

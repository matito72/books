import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/resources/action_result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LibroState<T> extends Equatable {
  final T ? data;
  final String? msg;
  final ActionResult? actionResult;

  const LibroState({this.data, this.msg, this.actionResult});

  @override
  List<Object?> get props => [data, msg, actionResult];
}

//* SUCCESS
abstract class LibroSuccessState<T> extends LibroState {
  const LibroSuccessState({T? super.data, super.msg}) : super(actionResult: ActionResult.success);
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
class ListaLibroLoadedState<T extends List<LibroViewModel>> extends LibroSuccessState {
  const ListaLibroLoadedState(List<LibroViewModel> data, String msg) : super(data: data, msg: msg);
}

//* ADDED NEW LIBRO
class AddedNewLibroState extends LibroSuccessState {
  const AddedNewLibroState(String msg) : super(msg: msg);
}

//* EXPORTED FILE
class ExportedFileState<int> extends LibroSuccessState {
  const ExportedFileState(int data, String msg) : super(data: data, msg: msg);
}

//* IMPORTED FILE
class ImportedFileState<int> extends LibroSuccessState {
  const ImportedFileState(int data, String msg) : super(data: data, msg: msg);
}

//* EDIT LIBRO
class EditLibroState extends LibroSuccessState {
  const EditLibroState(String msg) : super(msg: msg);
}

//* DELETE LIBRO
class DeletedLibroState<int> extends LibroSuccessState {
  const DeletedLibroState(String msg) : super(msg: msg);
}

//* DELETE ALL
class DeleteAllLibroState<int> extends LibroSuccessState {
  const DeleteAllLibroState(int data, String msg) : super(data: data, msg: msg);
}

//* ERRORE
class LibroErrorState extends LibroState {
  const LibroErrorState(String msg) : super(msg: msg, actionResult: ActionResult.failure);
}

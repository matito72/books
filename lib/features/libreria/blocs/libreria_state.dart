import 'package:books/features/libreria/data/models/libreria_model.dart';
import 'package:books/resources/action_result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LibreriaState<T> extends Equatable {
  final T ? data;
  final String? msg;
  final ActionResult? actionResult;

  const LibreriaState({this.data, this.msg, this.actionResult});

  @override
  List<Object?> get props => [data, msg, actionResult];
}

//* SUCCESS
abstract class LibreriaSuccessState<T> extends LibreriaState {
  const LibreriaSuccessState({T? super.data, super.msg}) : super(actionResult: ActionResult.success);
}

//* WAIT
class LibreriaWaitingState extends LibreriaSuccessState {
  const LibreriaWaitingState();
}

//* INIT
class LibreriaInitializedState extends LibreriaSuccessState {
  const LibreriaInitializedState(String msg) : super(msg: msg);
 }

//* ADDED NEW LIBRERIA
class AddedNewLibreriaState extends LibreriaSuccessState { 
  const AddedNewLibreriaState(String msg) : super(msg: msg);
}

//* DELETE
class DeleteLibreriaState extends LibreriaSuccessState { 
  const DeleteLibreriaState(String msg) : super(msg: msg);
}

//* EDIT
class EditLibreriaState extends LibreriaSuccessState {
  const EditLibreriaState(String msg) : super(msg: msg);
}

//* LISTA
class LibreriaLoadedState<T extends List<LibreriaModel>> extends LibreriaSuccessState {
  const LibreriaLoadedState(List<LibreriaModel> data, String msg) : super(data: data, msg: msg);
}

//* DISPOSE
class LibreriaModelDisposeState extends LibreriaState {
  const LibreriaModelDisposeState();
}

//* DELETE ALL
class DeleteAllLibreriaState extends LibreriaState {
  const DeleteAllLibreriaState(int data, String msg) : super(data: data, msg: msg);
}

//* ERRORE
class LibreriaErrorState extends LibreriaState {
 const LibreriaErrorState(String msg) : super(msg: msg, actionResult: ActionResult.failure);
}
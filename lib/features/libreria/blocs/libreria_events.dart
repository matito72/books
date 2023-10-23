import 'package:books/features/libreria/data/models/libreria_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LibreriaEvent extends Equatable {
  const LibreriaEvent();

  @override
  List<Object?> get props => [];
}

//* INIT
class InitLibreriaEvent extends LibreriaEvent { }

//* DISPOSE
class DisposeLibreriaEvent extends LibreriaEvent { }

//* DELETE ALL
class DeleteAllLibreriaEvent extends LibreriaEvent { }

//* NEW
class AddLibreriaEvent extends LibreriaEvent {
  final LibreriaModel libreriaModelNew;

  const AddLibreriaEvent(this.libreriaModelNew);
}

//* EDIT
class EditLibreriaEvent extends LibreriaEvent {
  final LibreriaModel libreriaModelOld;
  final LibreriaModel libreriaModelNew;

  const EditLibreriaEvent(this.libreriaModelOld, this.libreriaModelNew);
}

//* DELETE
class DeleteLibreriaEvent extends LibreriaEvent {
  final LibreriaModel libreriaModelDelete;

  const DeleteLibreriaEvent(this.libreriaModelDelete);
}

//* LIST
class LoadLibreriaEvent extends LibreriaEvent { 
  const LoadLibreriaEvent();
}
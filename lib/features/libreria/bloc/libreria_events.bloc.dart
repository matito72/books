import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
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
  final LibreriaIsarModel libreriaIsarModelNew;

  const AddLibreriaEvent(this.libreriaIsarModelNew);
}

//* EDIT
class EditLibreriaEvent extends LibreriaEvent {
  final LibreriaIsarModel libreriaIsarModelOld;
  final LibreriaIsarModel libreriaIsarModelNew;

  const EditLibreriaEvent(this.libreriaIsarModelOld, this.libreriaIsarModelNew);
}

//* DELETE
class DeleteLibreriaEvent extends LibreriaEvent {
  final LibreriaIsarModel libreriaIsarModelDelete;

  const DeleteLibreriaEvent(this.libreriaIsarModelDelete);
}

//* LIST
class LoadLibreriaEvent extends LibreriaEvent { 
  const LoadLibreriaEvent();
}

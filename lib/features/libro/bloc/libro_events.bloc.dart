import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/models/libro_isar_to_save.module.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LibroEvent extends Equatable {
  const LibroEvent();

  @override
  List<Object?> get props => [];
}

//* INIT
class InitLibroEvent extends LibroEvent { }

//* DISPOSE
class DisposeLibroEvent extends LibroEvent { }

//* EXPORT ALL BOOKS LIBRERIA
class ExportAllLibriLibreriaEvent extends LibroEvent { 
  final LibreriaIsarModel libreriaIsarModel;

  const ExportAllLibriLibreriaEvent(this.libreriaIsarModel);
}

//* IMPORT ALL BOOKS LIBRERIA
class ImportAllLibriLibreriaEvent extends LibroEvent { 
  final LibreriaIsarModel libreriaIsarModel;

  const ImportAllLibriLibreriaEvent(this.libreriaIsarModel);
}

//* DELETE ALL BOOKS LIBRERIA
class DeleteAllLibriLibreriaEvent extends LibroEvent { 
  final LibreriaIsarModel libreriaIsarModel;

  const DeleteAllLibriLibreriaEvent(this.libreriaIsarModel);
}

//* DELETE LIBRI SELEZIONATI
class DeleteBookSelectedEvent extends LibroEvent { 
  final List<SelectedItem<LibroIsarModel>> lstSelectedItem;

  const DeleteBookSelectedEvent(this.lstSelectedItem);
}

//* DELETE ALL LIBRI 
class DeleteAllLibriEvent extends LibroEvent { 
  const DeleteAllLibriEvent();
}

//* DEL LIBRO
class DeleteLibroEvent extends LibroEvent {
  final LibreriaIsarModel libreriaIsarModel;
  final LibroIsarModel libroModelDelete;

  const DeleteLibroEvent(this.libreriaIsarModel, this.libroModelDelete);
}

//* LIST
class LoadLibroEvent extends LibroEvent { 
  final List<LibreriaIsarModel> lstLibreriaIsarSel;

  const LoadLibroEvent(this.lstLibreriaIsarSel);
}

class CheckAllLibroEvent extends LibroEvent { 
  final List<SelectedItem<LibroIsarModel>> lstSelectedItem;

  const CheckAllLibroEvent(this.lstSelectedItem);
}

class DeCheckAllLibroEvent extends LibroEvent { 
  final List<SelectedItem<LibroIsarModel>> lstSelectedItem;

  const DeCheckAllLibroEvent(this.lstSelectedItem);
}

// class RefreshLibroEvent extends LibroEvent { 
//   final List<SelectedItem<LibroViewModel>> lstSelectedItem;

//   const RefreshLibroEvent(this.lstSelectedItem);
// }

// //* SEARCH by BARCODE SCAN
// class SearchLibroByBarcodeEvent extends LibroEvent { 
//   const SearchLibroByBarcodeEvent();
// }

// //* SEARCH by GOOGLE
// class SearchLibroByGoogleEvent extends LibroEvent { 
//   final ParameterGoogleSearchModel googleSearchModel;

//   const SearchLibroByGoogleEvent(this.googleSearchModel);
// }

//* NEW
class AddLibroEvent extends LibroEvent {
  final LibreriaIsarModel libreriaIsarModel;
  final LibroIsarToSaveModel libroToSaveModel;

  const AddLibroEvent(this.libreriaIsarModel, this.libroToSaveModel);
}

//* EDIT
class EditLibroEvent extends LibroEvent {
  final LibreriaIsarModel libreriaIsarModel;
  final LibroIsarToSaveModel libroToSaveModel;

  const EditLibroEvent(this.libreriaIsarModel, this.libroToSaveModel);
}
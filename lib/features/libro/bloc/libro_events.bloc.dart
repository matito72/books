import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
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
  final LibreriaModel libreriaModel;

  const ExportAllLibriLibreriaEvent(this.libreriaModel);
}

//* IMPORT ALL BOOKS LIBRERIA
class ImportAllLibriLibreriaEvent extends LibroEvent { 
  final LibreriaModel libreriaModel;

  const ImportAllLibriLibreriaEvent(this.libreriaModel);
}

//* DELETE ALL BOOKS LIBRERIA
class DeleteAllLibriLibreriaEvent extends LibroEvent { 
  final LibreriaModel libreriaModel;

  const DeleteAllLibriLibreriaEvent(this.libreriaModel);
}

//* DELETE LIBRI SELEZIONATI
class DeleteBookSelectedEvent extends LibroEvent { 
  final List<SelectedItem<LibroViewModel>> lstSelectedItem;

  const DeleteBookSelectedEvent(this.lstSelectedItem);
}

//* DELETE ALL LIBRI 
class DeleteAllLibriEvent extends LibroEvent { 
  const DeleteAllLibriEvent();
}

//* DEL LIBRO
class DeleteLibroEvent extends LibroEvent {
  final LibreriaModel libreriaModel;
  final LibroViewModel libroModelDelete;

  const DeleteLibroEvent(this.libreriaModel, this.libroModelDelete);
}

//* LIST
class LoadLibroEvent extends LibroEvent { 
  final List<LibreriaModel> lstLibreriaSel;

  const LoadLibroEvent(this.lstLibreriaSel);
}

class CheckAllLibroEvent extends LibroEvent { 
  final List<SelectedItem<LibroViewModel>> lstSelectedItem;

  const CheckAllLibroEvent(this.lstSelectedItem);
}

class DeCheckAllLibroEvent extends LibroEvent { 
  final List<SelectedItem<LibroViewModel>> lstSelectedItem;

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
  final LibreriaModel libreriaModel;
  final LibroViewModel libroModelNew;

  const AddLibroEvent(this.libreriaModel, this.libroModelNew);
}

//* EDIT
class EditLibroEvent extends LibroEvent {
  final LibreriaModel libreriaModel;
  final LibroViewModel libroModelEdit;

  const EditLibroEvent(this.libreriaModel, this.libroModelEdit);
}
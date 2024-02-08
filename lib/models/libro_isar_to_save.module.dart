import 'package:books/features/libro/data/models/libro_isar.module.dart';

class LibroIsarToSaveModel {
  LibroIsarModel libroViewModel;
  int? siglaLibreriaOld; 

  LibroIsarToSaveModel(this.libroViewModel, {this.siglaLibreriaOld});
}
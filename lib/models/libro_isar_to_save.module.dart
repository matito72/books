import 'package:books/features/libro/data/models/libro_isar.module.dart';

class LibroIsarToSaveModel {
  LibroIsarModel libroViewModel;
  int? siglaLibreriaOld; 
  String? isbnLibroOld; 

  LibroIsarToSaveModel(this.libroViewModel, {this.siglaLibreriaOld, this.isbnLibroOld});
}
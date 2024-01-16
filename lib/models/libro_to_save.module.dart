import 'package:books/features/libro/data/models/libro_view.module.dart';

class LibroToSaveModel {
  LibroViewModel libroViewModel;
  String? siglaLibreriaOld; 

  LibroToSaveModel(this.libroViewModel, {this.siglaLibreriaOld});
}
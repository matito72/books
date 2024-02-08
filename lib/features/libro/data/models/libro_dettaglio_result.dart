

import 'package:books/features/libro/data/models/libro_isar.module.dart';

class LibroDettaglioResult {
  LibroIsarModel libroViewModel;
  bool isInsert;
  bool isDelete;

  LibroDettaglioResult(this.libroViewModel, this.isInsert, this.isDelete);
}
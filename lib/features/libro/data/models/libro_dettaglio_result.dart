

import 'package:books/features/libro/data/models/libro_view_model.dart';

class LibroDettaglioResult {
  LibroViewModel libroViewModel;
  bool isInsert;
  bool isDelete;

  LibroDettaglioResult(this.libroViewModel, this.isInsert, this.isDelete);
}
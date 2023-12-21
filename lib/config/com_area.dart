

import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/resources/ordinamento_libri.dart';

class ComArea {
  static bool initApp = false;
  static LibreriaModel? _libreriaInUso;
  static int _nrLibriInLibreriaInUso = 0;
  static String _bookToSearch = '';
  static List<OrdinamentoLibri> _lstBookOrderBy = OrdinamentoLibri.values.map((e) => e).toList();

  static LibreriaModel? get libreriaInUso {
    return _libreriaInUso;
  }

  static void setLibreriaInUso(LibreriaModel libreriaSel) {
    _libreriaInUso = libreriaSel;
  }

  static int get nrLibriInLibreriaInUso {
    return _nrLibriInLibreriaInUso;
  }

  static void setNrLibriInLibreriaInUso(int nr) {
    _nrLibriInLibreriaInUso = nr;
  }

  static String get bookToSearch {
    return _bookToSearch;
  }

  static void setBookToSearch(String bookToSearch) {
    _bookToSearch = bookToSearch;
  }

  static List<OrdinamentoLibri> get lstBookOrderBy {
    return _lstBookOrderBy;
  }

  static void setLstBookOrderBy(List<OrdinamentoLibri> bookOrderBy) {
    _lstBookOrderBy = bookOrderBy;
  }
}


import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/resources/ordinamento_libri.dart';

class ComArea {
  static bool initApp = false;
  static LibreriaModel? libreriaInUso;
  
  static int nrLibriInLibreriaInUso = 0;
  static int nrLibriVisibiliInLista = 0;
  
  static String bookToSearch = '';
  static List<OrdinamentoLibri> lstBookOrderBy = OrdinamentoLibri.values();
  static bool orderByAsc = true;
}
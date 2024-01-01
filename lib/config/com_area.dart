import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/models/books_search_parameters.module.dart';
import 'package:books/resources/ordinamento_libri.dart';

class ComArea {
  static bool initApp = false;
  static LibreriaModel? libreriaInUso;
  
  static int nrLibriInLibreriaInUso = 0;
  static int nrLibriVisibiliInLista = 0;
  
  static List<OrdinamentoLibri> lstBookOrderBy = OrdinamentoLibri.values();
  static bool showOrderBy = true;
  static bool orderByAsc = true;

  static OrdinamentoLibri groupComparatorField = OrdinamentoLibri.autore(); 
  static OrdinamentoLibri itemComparatorField = OrdinamentoLibri.titolo(); 

  static bool appBarStateText = true;  // DEFAULT
  static String bookToSearch = '';
  static BooksSearchParameters booksSearchParameters = BooksSearchParameters();
}
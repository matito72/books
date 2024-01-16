import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/models/books_search_parameters.module.dart';
import 'package:books/resources/ordinamento_libri.dart';

class ComArea {
  static bool initApp = false;

  // LIBRERIA IN USO : DATA
  static List<LibreriaModel> lstLibrerieInUso = [];
  static Map<String, String> mapCodDescLibreria = {};
  static LibreriaModel? libreriaInUso;
  static int nrLibriInLibreriaInUso = 0;
  static int nrLibriVisibiliInLista = 0;
  
  // ORDER BY : DEFAULT
  static List<OrdinamentoLibri> lstBookOrderBy = OrdinamentoLibri.values();
  static bool showOrderBy = true;
  static bool orderByAsc = true;

  // GROUP BY : DEFAULT
  static OrdinamentoLibri groupComparatorField = OrdinamentoLibri.autore(); 
  static OrdinamentoLibri itemComparatorField = OrdinamentoLibri.titolo(); 

  // SEARCH (semplice e non) : DEFAULT
  static bool appBarStateText = true;  // DEFAULT
  static String bookToSearch = '';
  static BooksSearchParameters booksSearchParameters = BooksSearchParameters();
}
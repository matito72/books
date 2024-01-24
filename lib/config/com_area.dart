import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/models/books_search_parameters.module.dart';
import 'package:books/resources/libro_field_selected.dart';

class ComArea {
  static bool initApp = false;

  // LIBRERIA IN USO : DATA
  static List<LibreriaModel> lstLibrerieInUso = [];
  static Map<String, String> mapCodDescLibreria = {};
  static LibreriaModel? libreriaInUso;
  static int nrLibriInLibreriaInUso = 0;
  static int nrLibriVisibiliInLista = 0;
  
  // ORDER BY : DEFAULT
  static List<LibroFieldSelected> lstBookOrderBy = LibroFieldSelected.values();
  static bool showOrderBy = true;
  static bool orderByAsc = true;

  // GROUP BY : DEFAULT
  static LibroFieldSelected groupComparatorField = LibroFieldSelected.autore(); 
  static LibroFieldSelected itemComparatorField = LibroFieldSelected.titolo(); 

  // SEARCH (semplice e non) : DEFAULT
  static bool appBarStateText = true;  // DEFAULT
  static String bookToSearch = '';
  static BooksSearchParameters booksSearchParameters = BooksSearchParameters();

  static bool isBarcode = true;
}
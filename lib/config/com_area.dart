import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/models/books_search_parameters.module.dart';
import 'package:books/resources/libro_field_selected.dart';

class ComArea {
  static bool initApp = false;

  // LIBRERIA IN USO : DATA
  static List<LibreriaIsarModel> lstLibrerieInUso = [];
  static Map<int, String> mapCodDescLibreria = {};
  static LibreriaIsarModel? libreriaInUso;
  static int nrLibriInLibreriaInUso = 0;
  static int nrLibriVisibiliInLista = 0;
  
  // ORDER BY : DEFAULT
  static List<LibroFieldSelected> lstBookOrderBy = LibroFieldSelected.values();
  static bool showOrderBy = true;
  static bool orderByAsc = false;

  // GROUP BY : DEFAULT
  static LibroFieldSelected groupComparatorField = LibroFieldSelected.autore(); 
  static LibroFieldSelected itemComparatorField = LibroFieldSelected.titolo(); 

  // SEARCH (semplice e non) : DEFAULT
  static bool appBarStateText = true;  // DEFAULT
  static String bookToSearch = '';
  static BooksSearchParameters booksSearchParameters = BooksSearchParameters();

  static bool isBarcode = true;
}
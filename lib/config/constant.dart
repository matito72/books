import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/resources/ordinamento_libri.dart';


class Constant {
  static const String titoloApp = "BOOKs";
  static const String googleapisDominio = 'www.googleapis.com';
  static const String googleapisPercorso = '/books/v1/volumes';
  static const String jsonFilesPath = "jsonFiles";
  static const String editoreDaDefinire = '<Editore da definire>';
  static const String assetImageDefault = 'assets/images/waiting.png';

  static final LibreriaModel libreriaVuota = LibreriaModel(sigla: '', nome: '', nrLibriCaricati: 0);
  static bool initApp = false;
  static List<OrdinamentoLibri> lstBookOrderByDefault = OrdinamentoLibri.values.map((e) => e).toList();

  // -----------------------------------------------------------
  // -------------------------- CACHE --------------------------
  // -----------------------------------------------------------
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

  // -----------------------------------------------------------
}
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:intl/intl.dart';

class Constant {
  static const String titoloApp = "BOOKs";
  static const String googleapisDominio = 'www.googleapis.com';
  static const String googleapisPercorso = '/books/v1/volumes';
  static const String jsonFilesPath = "jsonFiles";
  static const String siglaLibreriaDaDefinire = '<Libreria da definire>';
  static const String editoreDaDefinire = '<Editore da definire>';
  static const String assetImageDefault = 'assets/images/waiting.png';

  static final LibreriaIsarModel libreriaVuota = LibreriaIsarModel(nome: '', nrLibriCaricati: 0);

 static const String dataDefault = '0000000000000000';
 static String now = DateFormat('yyyyMMdd').format(DateTime.now());
}
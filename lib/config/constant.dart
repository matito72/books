import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:intl/intl.dart';

class Constant {
  static const String titoloApp = "BOOKs";
  static const String googleapisDominio = 'www.googleapis.com';
  static const String googleapisPercorso = '/books/v1/volumes';
  static const String jsonFilesPath = "jsonFiles";
  static const String editoreDaDefinire = '<Editore da definire>';
  static const String assetImageDefault = 'assets/images/waiting.png';

  static final LibreriaModel libreriaVuota = LibreriaModel(sigla: '', nome: '', nrLibriCaricati: 0);

 static const String dataInserimentoDefault = '20240101';
static String now = DateFormat('yyyyMMdd').format(DateTime.now());
}
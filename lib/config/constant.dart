import 'package:books/features/libreria/data/models/libreria_model.dart';

class Constant {
  static const String titoloApp = "BOOKs";
  static const String googleapisDominio = 'www.googleapis.com';
  static const String googleapisPercorso = '/books/v1/volumes';
  static const String jsonFilesPath = "jsonFiles";

  // static LibreriaModel libreriaInUso = LibreriaModel('Tito', 'T');
  static final LibreriaModel libreriaVuota = LibreriaModel(sigla: '', nome: '', nrLibriCaricati: 0);

  static bool initApp = false;
  static LibreriaModel? _libreriaInUso;
  static int _nrLibriInLibreriaInUso = 0;

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
}
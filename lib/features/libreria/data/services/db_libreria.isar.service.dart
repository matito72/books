import 'dart:io';

import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:isar_community/isar.dart';


class DbLibreriaIsarService {
  static const String nomeBoxLibreriaDefault = "boxLibreria";
  final Directory _appDocumentDir;  
  DbLibreriaIsarService(this._appDocumentDir);

  Future<Isar> _openBoxLibreria() async {
    if (Isar.instanceNames.isEmpty || !Isar.instanceNames.contains(nomeBoxLibreriaDefault)) {
      if (Isar.getInstance(nomeBoxLibreriaDefault) != null && Isar.getInstance(nomeBoxLibreriaDefault)!.isOpen) {
        Isar.getInstance(nomeBoxLibreriaDefault)!.close();
      }
      return Isar.openSync(
        name: nomeBoxLibreriaDefault,
        [LibreriaIsarModelSchema], 
        directory: _appDocumentDir.path
      );
    }

    return Future.value(Isar.getInstance(nomeBoxLibreriaDefault));
  }

  Future<List<LibreriaIsarModel>> readLstLibreriaFromDb() async {
    Isar isarLibreria = await _openBoxLibreria();
    List<LibreriaIsarModel> lstLibreriaSaved = isarLibreria.libreriaIsarModels.where().findAllSync();
    await isarLibreria.close();

    return lstLibreriaSaved;
  }

  Future<void> changeLibreriaDefault(List<LibreriaIsarModel> lstSortedBySiglaLibreriaSel) async {
    Isar isarLibreria = await _openBoxLibreria();

    List<LibreriaIsarModel> lstLibreriaSaved = isarLibreria.libreriaIsarModels.where().findAllSync();
    if (lstLibreriaSaved.isNotEmpty) {
      for (LibreriaIsarModel libreriaModelIsar in lstLibreriaSaved) {
        LibreriaIsarModel? libreriaCheck = lstSortedBySiglaLibreriaSel.cast<LibreriaIsarModel?>().firstWhere((element) => element!.sigla == libreriaModelIsar.sigla, orElse: () => null);
        libreriaModelIsar.isLibreriaDefault = (libreriaCheck != null) ? true : false;

        await isarLibreria.writeTxn(() async {
          await isarLibreria.libreriaIsarModels.put(libreriaModelIsar);
        });
      }
    }

    await isarLibreria.close();
  }

  Future<void> addLibriInLibreriaInUso(int siglaLibreria, int nr, double valore) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(siglaLibreria).findFirst();
    libreria!.nrLibriCaricati += nr;
    libreria.valoreTot += valore;
    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.put(libreria);
    });
    
    await isarLibreria.close();
  }

  Future<void> removeLibroFromLibreriaInUso(int siglaLibreria, double valore) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(siglaLibreria).findFirst();
    libreria!.nrLibriCaricati--;
    libreria.valoreTot -= valore;
    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.put(libreria);
    });
    
    await isarLibreria.close();
  }

  Future<void> azzeraNrLibriInLibreriaInUso(int siglaLibreria) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(siglaLibreria).findFirst();
    libreria!.nrLibriCaricati = 0;
    libreria.valoreTot = 0;
    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.put(libreria);
    });
    
    await isarLibreria.close();
  }

  Future<void> insertLibreria(LibreriaIsarModel libreriaToAdd) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(libreriaToAdd.sigla).findFirst();
    if (libreria != null) {
      await isarLibreria.close();
      throw "Libreria '${libreriaToAdd.nome}' già presente!";
    }

    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.put(libreriaToAdd);
    });

    await isarLibreria.close();
  }

  Future<void> updateNomeLibreria(int siglaLibreria, String nomelibreriaOld, String nomelibreriaNew) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(siglaLibreria).findFirst();
    if (libreria == null) {
      await isarLibreria.close();
      throw "Libreria da modificare '$nomelibreriaOld' non trovata!";
    }
    libreria.nome = nomelibreriaNew;
    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.put(libreria);
    });

    await isarLibreria.close();
  }

  Future<void> saveLibreria(LibreriaIsarModel libreriaToSave) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(libreriaToSave.sigla).findFirst();
    if (libreria == null) {
      await isarLibreria.close();
      throw "Libreria da aggiornare '${libreriaToSave.nome}' non presente!";
    }

    libreria.pathImmagineLibreria = libreriaToSave.pathImmagineLibreria;
    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.put(libreria);
    });

    await isarLibreria.close();
  }

  Future<void> deleteLibreria(LibreriaIsarModel libreriaToDelete) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(libreriaToDelete.sigla).findFirst();
    if (libreria == null) {
      await isarLibreria.close();
      throw "Libreria '${libreriaToDelete.nome}' non presente!";
    }

    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.delete(libreria.sigla);
    });

    await isarLibreria.close();
  }

}
import 'dart:io';

import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:isar/isar.dart';


class DbLibreriaIsarService {
  
  final Directory _appDocumentDir;  
  DbLibreriaIsarService(this._appDocumentDir);

  Future<Isar> _openBoxLibreria() async {
    if (Isar.instanceNames.isEmpty || !Isar.instanceNames.contains('boxLibreria')) {
      if (Isar.getInstance('boxLibreria') != null && Isar.getInstance('boxLibreria')!.isOpen) {
        Isar.getInstance('boxLibreria')!.close();
      }
      return await Isar.open(
        name: 'boxLibreria', 
        [LibreriaIsarModelSchema], 
        directory: _appDocumentDir.path
      );
    }

    return Future.value(Isar.getInstance('boxLibreria'));
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

  Future<void> addLibriInLibreriaInUso(int siglaLibreria, int nr) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(siglaLibreria).findFirst();
    libreria!.nrLibriCaricati += nr;
        await isarLibreria.writeTxn(() async {
          await isarLibreria.libreriaIsarModels.put(libreria);
        });
    
    await isarLibreria.close();
  }

  Future<void> removeLibroFromLibreriaInUso(int siglaLibreria) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(siglaLibreria).findFirst();
    libreria!.nrLibriCaricati--;
        await isarLibreria.writeTxn(() async {
          await isarLibreria.libreriaIsarModels.put(libreria);
        });
    
    await isarLibreria.close();
  }

  Future<void> setNrLibriInLibreriaInUso(int siglaLibreria, int nr) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(siglaLibreria).findFirst();
    libreria!.nrLibriCaricati = nr;
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
      throw 'Libreria ${libreriaToAdd.nome} già presente!';
    }

    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.put(libreriaToAdd);
    });

    await isarLibreria.close();
  }

  Future<void> updateLibreria(LibreriaIsarModel libreriaNew) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(libreriaNew.sigla).findFirst();
    if (libreria == null) {
      await isarLibreria.close();
      throw 'Libreria ${libreriaNew.nome} già presente!';
    }  
    
    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.put(libreriaNew);
    });

    await isarLibreria.close();
  }

  Future<void> deleteLibreria(LibreriaIsarModel libreriaToDelete) async {
    Isar isarLibreria = await _openBoxLibreria();

    final LibreriaIsarModel? libreria = await isarLibreria.libreriaIsarModels.filter().siglaEqualTo(libreriaToDelete.sigla).findFirst();
    if (libreria == null) {
      await isarLibreria.close();
      throw 'Libreria ${libreriaToDelete.nome} non presente!';
    }

    await isarLibreria.writeTxn(() async {
      await isarLibreria.libreriaIsarModels.delete(libreria.sigla);
    });

    await isarLibreria.close();
  }

}
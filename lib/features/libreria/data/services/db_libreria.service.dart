import 'dart:io';

import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class DbLibreriaService {

  final Directory _appDocumentDir;
  DbLibreriaService(this._appDocumentDir);


  Future<bool> init() async {
    // ** INIT LibreriaModel  - LibroViewModel
    WidgetsFlutterBinding.ensureInitialized();
    Hive.init(_appDocumentDir.path);
    Hive.registerAdapter(LibreriaModelAdapter());

    // _boxLibreria = await Hive.openBox<LibreriaModel>('boxLibreria');

    debugPrint('_boxLibreria - INIZIALIZZATO !!');
    return true;
  }

  bool isServiceInitialized() {
    return Hive.isAdapterRegistered(LibreriaModelAdapter().typeId);
  }

  Future<Box<LibreriaModel>> _openBoxLibreria() async {
     return await Hive.openBox<LibreriaModel>('boxLibreria');
  }

  Future<void> dispose() async {
    debugPrint('DISPOSE - ....');
    
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();
    await boxLibreria.compact();
    await boxLibreria.close();
    await Hive.close();

    debugPrint('DISPOSE - stop');
  }

  Future<List<LibreriaModel>> readLstLibreriaFromDb() async {
    List<LibreriaModel> lstLibreriaSaved = [];
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    lstLibreriaSaved.addAll(boxLibreria.keys.map((key) {
      final item = boxLibreria.get(key);
      LibreriaModel libreriaToAdd = LibreriaModel(sigla: item!.sigla, nome: item.nome,  nrLibriCaricati: item.nrLibriCaricati, isLibreriaDefault: item.isLibreriaDefault);
      if (libreriaToAdd.isLibreriaDefault) {
        ComArea.setLibreriaInUso(libreriaToAdd);
        ComArea.setNrLibriInLibreriaInUso(libreriaToAdd.nrLibriCaricati);
      }
      return libreriaToAdd;
    }).toList());
    await boxLibreria.close();

    return lstLibreriaSaved;
  }

  Future<bool> changeLibreriaDefault(LibreriaModel libreriaSel) async {
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    for (var i = 0; i < boxLibreria.length; i++) {
      LibreriaModel? libreriaDb = boxLibreria.getAt(i);
      if (libreriaDb != null) {
        libreriaDb.isLibreriaDefault = (libreriaSel.sigla == libreriaDb.sigla) ? true : false;
        await libreriaDb.save();
      }
    }
    await boxLibreria.close();

    return true;
  }

  Future<void> addLibriInLibreriaInUso(int nr) async {
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    LibreriaModel? libreria = boxLibreria.get(ComArea.libreriaInUso!.sigla);
    libreria!.nrLibriCaricati += nr;
    await libreria.save();
    await boxLibreria.close();

    ComArea.setLibreriaInUso(libreria);
    ComArea.setNrLibriInLibreriaInUso(libreria.nrLibriCaricati);
  }

  Future<void> removeLibroFromLibreriaInUso() async {
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    LibreriaModel? libreria = boxLibreria.get(ComArea.libreriaInUso!.sigla);
    libreria!.nrLibriCaricati--;
    await libreria.save();
    await boxLibreria.close();

    ComArea.setLibreriaInUso(libreria);
    ComArea.setNrLibriInLibreriaInUso(libreria.nrLibriCaricati);
  }

  Future<void> setNrLibriInLibreriaInUso(int nr) async {
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    LibreriaModel? libreria = boxLibreria.get(ComArea.libreriaInUso!.sigla);
    libreria!.nrLibriCaricati = nr;
    await libreria.save();
    await boxLibreria.close();
    
    ComArea.setLibreriaInUso(libreria);
    ComArea.setNrLibriInLibreriaInUso(libreria.nrLibriCaricati);
  }

  Future<void> insertLibreria(LibreriaModel libreriaToAdd) async {
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    LibreriaModel? libreria = boxLibreria.get(libreriaToAdd.sigla);
    if (libreria != null) {
      await boxLibreria.close();
      throw 'Libreria ${libreria.nome} già presente!';
    }

    if (boxLibreria.isEmpty) {
      libreriaToAdd.isLibreriaDefault = true;
    }

    await boxLibreria.put(libreriaToAdd.sigla, libreriaToAdd);
    await boxLibreria.close();
  }

  Future<void> updateLibreria(LibreriaModel libreriaOld, LibreriaModel libreriaNew) async {
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    LibreriaModel? libreria = boxLibreria.get(libreriaNew.sigla);
    if (libreria == null) {
      await boxLibreria.close();
      throw 'Libreria ${libreriaNew.nome} non presente!';
    }

    libreria.nrLibriCaricati = libreriaNew.nrLibriCaricati;
    libreria.nome = libreriaNew.nome;
    await libreria.save();

    await boxLibreria.close();
  }

  Future<void> deleteLibreria(LibreriaModel libreriaToDelete) async {
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    LibreriaModel? libreria = boxLibreria.get(libreriaToDelete.sigla);
    if (libreria == null) {
      await boxLibreria.close();
      throw 'Libreria ${libreriaToDelete.nome} non presente!';
    }

    await boxLibreria.delete(libreriaToDelete.sigla);

    await boxLibreria.close();
  }

  Future<int> deleteAllLibrerie() async {
    Box<LibreriaModel> boxLibreria = await _openBoxLibreria();

    int nrRecordDeleted = await boxLibreria.clear();
    await boxLibreria.compact();

    await boxLibreria.close();
    return nrRecordDeleted;
  }
}
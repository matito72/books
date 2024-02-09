import 'dart:developer';
import 'dart:io';

import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

void main() {
  late Isar isarLibro;
  late Directory dirTest;

  setUp(() async {
    dirTest = Directory.systemTemp.createTempSync();
    await Isar.initializeIsarCore(download: true);

    if (Isar.instanceNames.isEmpty) {
        isarLibro = await Isar.open(
          name: 'Tito', 
          [LibroIsarModelSchema], 
          directory: dirTest.path
        );
      }
  });

  test("Open an instance on the Isar database", () async {
    final isOpen = isarLibro.isOpen;
    expect(isOpen, true);
  });

  group("Test Libreria", () { 
    final libro_1 = LibroIsarModel(1, Constant.now, Constant.now, isbn: '123', titolo: 'blabla bla ... Titolo 1 blabla bla ... ', editore: 'Editore 1', lstAutori: ['Aut. 1,1', 'Autore 1,2']);
    final libro_2 = LibroIsarModel(1, Constant.now, Constant.now, isbn: '456', titolo: 'blabla bla ... Titolo 2 blabla bla ... ', editore: 'Editore 2', lstAutori: ['Aut. 2,1', 'Autore 2,2']);
    final libro_3 = LibroIsarModel(1, Constant.now, Constant.now, isbn: '789', titolo: 'blabla bla ... Titolo 3 blabla bla ... ', editore: 'Editore 3', lstAutori: ['Aut. 3,1', 'Autore 3,2']);
    final libro_4 = LibroIsarModel(1, Constant.now, Constant.now, isbn: '101112', titolo: 'blabla bla ... Titolo 4 blabla bla ... ', editore: 'Editore 4', lstAutori: ['Aut. 4,1', 'Autore 4,2']);

    test("create 4 New Libro", () async {
      await isarLibro.writeTxn(() async {
        await isarLibro.libroIsarModels.putAll([libro_1, libro_2, libro_3, libro_4]);
      });

      final libro = await isarLibro.libroIsarModels.get(2);
      expect(libro?.titolo, libro_2.titolo);

      List<LibroIsarModel> lstLibroViewSaved = await isarLibro.libroIsarModels.filter()
        .titoloMatches('*titolo 2*', caseSensitive: false)
        // .lstAutoriElementMatches('*Autore 3*', caseSensitive: false)
        // .editoreMatches('*Editore*', caseSensitive: false)
        .siglaLibreriaEqualTo(1)
        .findAll();

      log('${lstLibroViewSaved.length}');

      await isarLibro.writeTxn(() async {
        await isarLibro.libroIsarModels.clear();
      });
    });
  });

  tearDownAll(() async {
    await isarLibro.close(deleteFromDisk: true);
  });
}
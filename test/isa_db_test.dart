import 'dart:io';

import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

void main() {
  late Isar isarTest;
  late Directory dirTest;

  setUp(() async {
    dirTest = Directory.systemTemp.createTempSync();
    await Isar.initializeIsarCore(download: true);

    if (Isar.instanceNames.isEmpty) {
        isarTest = await Isar.open(
          name: 'boxLibreria', 
          [LibreriaIsarModelSchema], 
          directory: dirTest.path
        );
      }
  });

  test("Open an instance on the Isar database", () async {
    final isOpen = isarTest.isOpen;
    expect(isOpen, true);
  });

  group("Test Libreria", () { 
    final libreria = LibreriaIsarModel(
      nome: 'Test-Tito',
      isLibreriaDefault: true, 
      nrLibriCaricati: 0
    );

    test("create New Libreria", () async {
      await isarTest.writeTxn(() async {
        await isarTest.libreriaIsarModels.put(libreria);
      });

      final lbr = await isarTest.libreriaIsarModels.get(libreria.sigla);
      expect(lbr?.sigla, libreria.sigla);

      await isarTest.writeTxn(() async {
        await isarTest.libreriaIsarModels.clear();
      });
    });

    test("read Libreria object", () async {
      await isarTest.writeTxn(() async {
        await isarTest.libreriaIsarModels.put(libreria);
      });

      final readLibreria = await isarTest.libreriaIsarModels.get(1);

      expect(readLibreria?.nome, 'Test-Tito');
      expect(readLibreria?.isLibreriaDefault, true);

      await isarTest.writeTxn(() async {
        await isarTest.libreriaIsarModels.clear();
      });
    });
  });

  tearDownAll(() async {
    await isarTest.close(deleteFromDisk: true);
  });
}
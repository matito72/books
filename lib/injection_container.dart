import 'dart:io';

import 'package:books/features/import_export/bloc/import_export.bloc.dart';
import 'package:books/features/import_export/data/services/import_export.service.dart';
import 'package:books/features/libreria/bloc/libreria.bloc.dart';
import 'package:books/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:books/features/libro/data/services/db_libro.service.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // ** Service HIVE
  final Directory appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  sl.registerSingleton<DbLibreriaIsarService>(DbLibreriaIsarService(appDocumentDir));
  sl.registerSingleton<DbLibroService>(DbLibroService(appDocumentDir));

  // ** Service BL
  sl.registerSingleton<ImportExportService>(ImportExportService(appDocumentDir));

  // ** Blocs
  sl.registerFactory<LibreriaBloc>(
    () => LibreriaBloc(sl())
  );

  // sl.registerFactory<LibroBloc>(
  //   () => LibroBloc(sl())
  // );

  sl.registerFactory<ImportExportBloc>(
    () => ImportExportBloc(sl())
  );

}
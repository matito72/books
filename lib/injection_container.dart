import 'dart:io';

import 'package:books/features/import_export/blocs/import_export_bloc.dart';
import 'package:books/features/import_export/data/repository/import_export_service.dart';
import 'package:books/features/libreria/blocs/libreria_bloc.dart';
import 'package:books/features/libreria/data/repository/db_libreria_service.dart';
import 'package:books/features/libro/blocs/libro_bloc.dart';
import 'package:books/features/libro/data/repository/db_libro_service.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // ** Service HIVE
  final Directory appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  sl.registerSingleton<DbLibreriaService>(DbLibreriaService(appDocumentDir));
  sl.registerSingleton<DbLibroService>(DbLibroService());

  // ** Service
  sl.registerSingleton<ImportExportService>(ImportExportService(appDocumentDir));

  // ** Blocs
  sl.registerFactory<LibreriaBloc>(
    ()=> LibreriaBloc(sl())
  );

  sl.registerFactory<LibroBloc>(
    ()=> LibroBloc(sl())
  );

  sl.registerFactory<ImportExportBloc>(
    () => ImportExportBloc(sl())
  );
}
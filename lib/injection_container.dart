import 'dart:io';

import 'package:book/features/import_export/bloc/import_export.bloc.dart';
import 'package:book/features/import_export/data/services/export_into_excel_service.dart';
import 'package:book/features/import_export/data/services/import_export.service.dart';
import 'package:book/features/libreria/bloc/libreria.bloc.dart';
import 'package:book/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:book/features/libro/data/services/db_libro_isar.service.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final Directory dbAppDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  // ** Service HIVE
  sl.registerSingleton<DbLibreriaIsarService>(DbLibreriaIsarService(dbAppDocumentDir));
  sl.registerSingleton<DbLibroIsarService>(DbLibroIsarService(dbAppDocumentDir));

  // ** Service BL
  final Directory appDocumentDir =  (!Platform.isAndroid && !Platform.isIOS) ? await path_provider.getApplicationDocumentsDirectory() : Directory('/storage/emulated/0/Download/');
  sl.registerSingleton<ImportExportService>(ImportExportService(appDocumentDir));
  sl.registerSingleton<ExportIntoExcelService>(ExportIntoExcelService(appDocumentDir));

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
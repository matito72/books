import 'dart:io';

import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/import_export/bloc/import_export.bloc.dart';
import 'package:books/features/import_export/bloc/import_export_events.bloc.dart';
import 'package:books/features/import_export/bloc/import_export_state.bloc.dart';
import 'package:books/features/import_export/data/models/file_backup.module.dart';
import 'package:books/injection_container.dart';
import 'package:books/resources/action_result.dart';
import 'package:books/widgets/appbar/appbar_default.dart';
import 'package:books/widgets/lista_file_backup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

///
/// Pagina GESTIONE BACKUP
///
class ImportExportFile extends StatelessWidget {
  static const String pagePath = '/HomeLibriLibreria/importExportFile';
  final String? _siglaLibreria;

  const ImportExportFile({super.key, String? siglaLibreria}) : _siglaLibreria = siglaLibreria;
  
  @override
  Widget build(BuildContext context) {
    String siglaLibreriaSearch = _siglaLibreria ?? ComArea.libreriaInUso!.sigla;
    ImportExportBloc importExportBloc = sl<ImportExportBloc>();
    
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _importFile(context, importExportBloc),
          child: const Icon(Icons.file_download),
        ),
        body: _blocBody(context, importExportBloc, siglaLibreriaSearch),
      ),
    );
  }
  
  _buildAppbar(BuildContext context) {
    return AppBarDefault(
      context: context,
      txtLabel: '${Constant.titoloApp} - Restore file backup'
    );
  }
  
  _importFile(BuildContext context, ImportExportBloc importExportBloc) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      
      var path = file.path;
      int pathFileIdx = path.lastIndexOf(Platform.pathSeparator);
      FileBackupModel fileBackupModel = FileBackupModel(
        siglaLibreria: ComArea.libreriaInUso!.sigla, 
        fileName: path.substring(pathFileIdx + 1), 
        nrRecord: 1
      );

      importExportBloc.add(ImportFileBackupEvent(path.substring(0, pathFileIdx + 1), fileBackupModel));
    } else {
      debugPrint("User canceled the picker");
    }
  }

  Widget _widgetListaFileBackup(BuildContext context, ImportExportBloc importExportBloc, List<FileBackupModel> lstFileBackupModel) {
    if (lstFileBackupModel.isEmpty) {
      return const Center(
        child: Text('Nessun file di backup presente.'),
      );
    } else {
      return ListaFileBakcup(importExportBloc, lstFileBackupModel);
    }
  }
  
  Widget _blocBody(BuildContext context, ImportExportBloc importExportBloc, String siglaLibreriaSearch) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImportExportBloc>(
          create: (BuildContext context) => importExportBloc..add(InitImportExportEvent()),
            // ..add(LoadFileBackupEvent(siglaLibreriaSearch)),
        ),
      ],
      child: BlocListener<ImportExportBloc, ImportExportState>(
        listener: (BuildContext context, ImportExportState state) {
          if (state.actionResult != null && state.msg != null) {
              // --------------------------------------------------------
              // GESTIONE MESSAGGI OK e d'ERRORE
              // --------------------------------------------------------
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: (state.actionResult == ActionResult.success)
                    ? Colors.green
                    : Colors.red,
                  content: Text(state.msg!),
                  duration: (state.actionResult == ActionResult.success)
                    ? const Duration(seconds: 1)
                    : const Duration(seconds: 5),
                )
              );
          }

          if (state is ExportedFileBackupState || state is DeletedFileBackupState || state is DeleteAllFileBackupState ||
              state is ImportExportInitializedState) {
            importExportBloc.add(LoadFileBackupEvent(siglaLibreriaSearch));
          } else if (state is ImportedFileBackupState) {
              Navigator.pop(context, true);
          }
        },
        child: BlocBuilder<ImportExportBloc, ImportExportState>(
          builder: (context, state) {
            if (state is ImportExportWaitingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } 
            if (state is ListaFileBackupLoadedState) {
              return _widgetListaFileBackup(context, importExportBloc, state.data);
            } 
            if (state is ImportExportErrorState) {
              return Center(child:  Text("Error: ${state.msg}"));
            }

            debugPrint('=================== Hummm =================== ${state.toString()}');
            return const Text('Hummm ... caso imprevisto ....');
          },
        )
      ),
    );
    
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<ImportExportBloc>(
    //       create: (BuildContext context) => importExportBloc..add(InitImportExportEvent()),
    //         // ..add(LoadFileBackupEvent(siglaLibreriaSearch)),
    //     ),
    //   ],
    //   child: BlocListener<ImportExportBloc, ImportExportState>(
    //     listener: (BuildContext context, ImportExportState state) {
    //       if (state.actionResult != null && state.msg != null) {
    //           // --------------------------------------------------------
    //           // GESTIONE MESSAGGI OK e d'ERRORE
    //           // --------------------------------------------------------
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               backgroundColor: (state.actionResult == ActionResult.success)
    //                 ? Colors.green
    //                 : Colors.red,
    //               content: Text(state.msg!),
    //               duration: (state.actionResult == ActionResult.success)
    //                 ? const Duration(seconds: 1)
    //                 : const Duration(seconds: 5),
    //             )
    //           );
    //       }

    //       if (state is ExportedFileBackupState || state is DeletedFileBackupState || state is DeleteAllFileBackupState ||
    //           state is ImportExportInitializedState) {
    //         importExportBloc.add(LoadFileBackupEvent(siglaLibreriaSearch));
    //       } else if (state is ImportedFileBackupState) {
    //           Navigator.pop(context, true);
    //       }
    //     },
    //     child: BlocBuilder<ImportExportBloc, ImportExportState>(
    //       builder: (context, state) {
    //         if (state is ImportExportWaitingState) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } 
    //         if (state is ListaFileBackupLoadedState) {
    //           return _widgetListaFileBackup(context, importExportBloc, state.data);
    //         } 
    //         if (state is ImportExportErrorState) {
    //           return Center(child:  Text("Error: ${state.msg}"));
    //         }

    //         debugPrint('=================== Hummm =================== ${state.toString()}');
    //         return const Text('Hummm ... caso imprevisto ....');
    //       },
    //     )
    //   ),
    // );
  }

}
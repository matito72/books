import 'package:books/config/constant.dart';
import 'package:books/features/libreria/blocs/libreria_state.dart';
import 'package:books/features/libro/blocs/libro_bloc.dart';
import 'package:books/features/libro/blocs/libro_events.dart';
import 'package:books/features/libro/blocs/libro_state.dart';
import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/injection_container.dart';
import 'package:books/pages/import_export_file.dart';
import 'package:books/pages/libreria_lista_libri_page.dart';
import 'package:books/resources/action_result.dart';
import 'package:books/services/libro_search_service.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/widgets/app_bar/app_bar_default.dart';
import 'package:books/widgets/app_bar/home_libri_libreria_appbar_content.dart';
import 'package:books/widgets/new_libro_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

///
/// Pagina con la lista dei libri della libreria selezionata
///
enum MenuItemCode {
  deleteAllBooksInLibreria(0, "Elimina tutti i libri di {0}"),
  exportAllBooksLibreria(10, "Crea file backup"),
  // importaBooksInLibreria(20, "Importa  libri ...."),
  restoreFileBackup(25, "Gestione files backup"),
  deleteAllBooksInAllLibrerie(30, "Elimina TUTTI i Libri."),
  ;

  final int cd;
  final String label;
  const MenuItemCode(this.cd, this.label);
}

class HomeLibriLibreriaScreen extends StatelessWidget {
  static const String screenPath = "/HomeLibriLibreria";
  late final LibroBloc libroBloc;

  HomeLibriLibreriaScreen({super.key}) {
    libroBloc = sl<LibroBloc>();
  }
  
  @override
  Widget build(BuildContext context) {
    // final LibroBloc libroBloc = sl<LibroBloc>();

    return Scaffold(
      appBar: _buildAppbar(context, libroBloc),
      body: _blocBody(context, libroBloc),
      floatingActionButton: FloatingActionButton(
        child: const Icon(MdiIcons.barcodeScan),
        onPressed: () => { _searchBookByBarcode(context, libroBloc) },
      ),
    );
  }

  _buildAppbar(BuildContext context, LibroBloc libroBloc) {
    return AppBarDefault(
      context: context,
      appBarContent: BlocProvider<LibroBloc>(
        create: (context) => libroBloc,
        child: HomeLibriLibreriaAppBarContent(libroBloc, _fnRestoreFileBackup),
      ),
    );
  }

  Widget _blocBody(BuildContext context, LibroBloc libroBloc) {
    return BlocProvider<LibroBloc>(
      create: (context) => libroBloc..add(InitLibroEvent()),
      child: BlocListener<LibroBloc, LibroState>(
        listener: (context, LibroState state) {
          if (state.actionResult != null && state.msg != null) {
            if (state is! LibreriaLoadedState && state is! LibroInitializedState) { // || state.actionResult != ActionResult.success) {
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
          }
          if (state is AddedNewLibroState || state is EditLibroState || state is DeletedLibroState ||
              state is LibroInitializedState || state is DeleteAllLibroState) {
            libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!));
          } else  if (state is ExportedFileState) {
            _fnRestoreFileBackup(context, libroBloc);
          }
        },
        child: BlocBuilder<LibroBloc, LibroState>(
          // buildWhen: (context, state) {
          //   return state is ListaLibroLoadedState;
          // },
          builder: (context, state) {
            if (state is LibroWaitingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ListaLibroLoadedState) {
              return widgetListaLibriDataBase(context, libroBloc, state.data);
            } 
            
            if (state is LibroErrorState) {
              return Center(child:  Text("Error: ${state.msg}"));
            }

            debugPrint('=================== Hummm =================== ${state.toString()}');
            return const Text('Hummm ... caso imprevisto ....');

            // return const Center(
            //   child: CircularProgressIndicator(),
            // );
          },
        )
      ),
    );
  }

  /// Gestione Andata/Ritorno alla/dalla pagina di Gestione File di Backup
  /// 
  _fnRestoreFileBackup(BuildContext context, LibroBloc libroBloc) async {
    // await Navigator.pushNamed<dynamic> (context, ImportExportFile.pagePath);
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ImportExportFile()),
    );
    if (context.mounted) {
      // Navigator.pop(context);
      libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!));
    }
  }

  Widget widgetListaLibriDataBase(BuildContext context, LibroBloc libroBloc, List<LibroViewModel> lstLibroViewModel) {
    return LibreriaListaLibriWidget(context, libroBloc, lstLibroViewModel, _viewEditLibro, _deleteLibro);
  }

  _searchBookByBarcode(BuildContext context, LibroBloc libroBloc) async {
    List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode( await LibroSearchService.scanBarcodeNormal()); //** OK */
    // List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode('9788804680604'); // !!! TEST !!!
    // List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode('PIPPO'); // !!! TEST !!!

    if (lstLibroViewModel.isEmpty) {
      if (context.mounted) {
        _openModalBottomSheet(context, libroBloc);
      }
    } else {
      if (context.mounted) {
        _viewDettaglioLibro(context, libroBloc, lstLibroViewModel.first);
      }
    }
  }

  _viewEditLibro(BuildContext context, LibroBloc libroBloc, LibroViewModel libroViewModel) async {
    LibroDettaglioResult? ret = await LibroUtils.viewDettaglioLibro(context, Constant.libreriaInUso!, libroViewModel, true);

    if (ret != null) {
      if (ret.isDelete) {
        libroBloc.add(DeleteLibroEvent(Constant.libreriaInUso!, ret.libroViewModel));
      } else if (ret.isInsert) {
        libroBloc.add(EditLibroEvent(Constant.libreriaInUso!, ret.libroViewModel));
      }
    }
  }

  _viewDettaglioLibro(BuildContext context, LibroBloc libroBloc, LibroViewModel libroViewModel) async {
    LibroDettaglioResult? libroDettaglioResult = await LibroUtils.viewDettaglioLibro(context, Constant.libreriaInUso!, libroViewModel, false);

    if (libroDettaglioResult != null && libroDettaglioResult.isInsert) {
      libroBloc.add(AddLibroEvent(Constant.libreriaInUso!, libroDettaglioResult.libroViewModel));
    }
  }

  _deleteLibro(BuildContext context, LibroBloc libroBloc, LibroViewModel libroViewModel) async {
    bool? isDelete = await DialogUtils.showConfirmationSiNo(context, 'Vuoi eliminare il libro dalla libreria ?');
    
    if (isDelete != null && isDelete) {
      libroBloc.add(DeleteLibroEvent(Constant.libreriaInUso!, libroViewModel));
    }
  }

  void _addNewLibro(LibroBloc libroBloc, LibroViewModel? libroViewModel) {
    if (libroViewModel != null) {
      libroBloc.add(AddLibroEvent(
        Constant.libreriaInUso!, 
        libroViewModel
      ));
    }
  }

  void _openModalBottomSheet(BuildContext context, LibroBloc libroBloc) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                    child: GestureDetector(
                        onTap: () {},
                        behavior: HitTestBehavior.translucent,
                        child: NewLibroWidget(_addNewLibro, libroBloc), //, _execSimpleGoogleBooksSearch),                      
                      ),
                    )
              ],
            ),
        ),
      )
    );
  }
}


import 'package:books/config/constant.dart';
import 'package:books/features/appbar/blocs/app_bar_bloc.dart';
import 'package:books/features/appbar/blocs/app_bar_events.dart';
import 'package:books/features/appbar/blocs/app_bar_state.dart';
import 'package:books/features/libreria/blocs/libreria_state.dart';
import 'package:books/features/libro/blocs/libro_bloc.dart';
import 'package:books/features/libro/blocs/libro_events.dart';
import 'package:books/features/libro/blocs/libro_state.dart';
import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/features/libro/data/repository/db_libro_service.dart';
import 'package:books/injection_container.dart';
import 'package:books/pages/import_export_file.dart';
import 'package:books/pages/libreria_lista_libri_page.dart';
import 'package:books/resources/action_result.dart';
import 'package:books/services/libro_search_service.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/widgets/app_bar/app_bar_default.dart';
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
  restoreFileBackup(25, "Gestione files backup"),
  deleteAllBooksInAllLibrerie(30, "Elimina TUTTI i Libri."),
  ;

  final int cd;
  final String label;
  const MenuItemCode(this.cd, this.label);
}

class HomeLibriLibreriaScreen extends StatelessWidget {
  static const String screenPath = "/HomeLibriLibreria";
  
  const HomeLibriLibreriaScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LibroBloc>(
          create: (_) => LibroBloc(sl<DbLibroService>())..add(InitLibroEvent()),
        ),
        BlocProvider<AppBarBloc>(
          create: (_) => AppBarBloc()..add(SwithToTextAppBarEvent()),
        ),
      ],
      child: BlocBuilder<AppBarBloc, AppBarState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppbar(context), 
            body: _blocBody(context),
            floatingActionButton: FloatingActionButton(
              child: const Icon(MdiIcons.barcodeScan),
              onPressed: () => _searchBookByBarcode(context)
            ),
          );
        }
      )
    );
  }

  _buildAppbar(BuildContext context) {
    AppBarBloc appBarBloc = context.read<AppBarBloc>();
    LibroBloc libroBloc = context.read<LibroBloc>();
    // --- SEARCH    
    TextEditingController textController = TextEditingController();

    return AppBarDefault(
      context: context,
      iconSx: IconButton(
        padding: EdgeInsets.zero,
        icon: BlocBuilder<LibroBloc, LibroState>(
          builder: (context, state) {
            if (appBarBloc.state is TextAppBarState || appBarBloc.state is RefreshAppBarState) {
              return const Icon(Icons.menu);
            }
            return const Icon(Icons.close);
          }
        ),
        onPressed: () {
          if (appBarBloc.state is SearchAppBarState) {
            appBarBloc.add(SwithToTextAppBarEvent());
          } else {
            appBarBloc.add(SwithToSearchAppBarEvent());            
          }
        },
      ),
      // primaryColor: (appBarBloc.state is TextAppBarState || appBarBloc.state is RefreshAppBarState)
      //   ? Colors.blue
      //   : Colors.blue[900],
      // secondaryColor: (appBarBloc.state is TextAppBarState || appBarBloc.state is RefreshAppBarState)
      //   ? Colors.pink
      //   : Colors.black,
      appBarContent: BlocBuilder<LibroBloc, LibroState>(
        builder: (context, state) {
          if (appBarBloc.state is TextAppBarState || appBarBloc.state is RefreshAppBarState) {
            // LABEL : default
            textController.clear();
            if (Constant.bookToSearch.isNotEmpty) {
              libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!));
            }
            Constant.setBookToSearch('');
            return Text('Libreria ${Constant.libreriaInUso!.nome}: ${Constant.libreriaInUso!.nrLibriCaricati} libri');
          }

          return TextField(
            controller: textController,
            textAlignVertical: TextAlignVertical.center,
            autofocus: true,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 180, 218, 228),
              hintText: 'Search...',
              hintStyle: const TextStyle(color: Colors.black),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                color: Colors.black,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.search),
                onPressed: () {
                  Constant.setBookToSearch(textController.text);
                  libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!));
                  FocusScope.of(context).unfocus();
                  // textController.clear();
                },
              ),
              isCollapsed: true,
              isDense: true
            ),
          );
        }      
      ),
      popupMenuButton: _createAppBarPopupMenuButton(context),
    );
  }

  PopupMenuButton _createAppBarPopupMenuButton(BuildContext context) {
    LibroBloc libroBloc = context.read<LibroBloc>();

    return PopupMenuButton(
      padding: EdgeInsets.zero,
      offset: const Offset(0, 35),
      elevation: 20,
      splashRadius: 200,
      shadowColor: Colors.blueGrey[800],
      surfaceTintColor: Colors.blueGrey[700],
      // color: Color.fromARGB(223, 173, 173, 31),
      color: Color.fromARGB(224, 88, 136, 182),
      shape: RoundedRectangleBorder(
        side: BorderSide.lerp(BorderSide.none, BorderSide.none, 12),
        borderRadius: BorderRadius.circular(12),
      ),
      icon: const Icon(Icons.more_vert, color: Colors.white),
      itemBuilder: (context) {
        return [
              PopupMenuItem<int>(
                value: MenuItemCode.exportAllBooksLibreria.cd, 
                child: Row(
                  children: [
                    Padding(padding: const EdgeInsets.only(right: 10.0), child: Icon(Icons.save_alt, color: Colors.green[100]),),
                    Text(
                      MenuItemCode.exportAllBooksLibreria.label.replaceFirst('{0}', Constant.libreriaInUso!.nome),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ),
              // PopupMenuItem<int>(value: MenuItemCode.importaBooksInLibreria.cd, child: Text(MenuItemCode.importaBooksInLibreria.label)),
              PopupMenuItem<int>(
                value: MenuItemCode.restoreFileBackup.cd, 
                child: Row(
                  children: [
                    Padding(padding: const EdgeInsets.only(right: 10.0), child: Icon(Icons.restore_page, color: Colors.lightGreenAccent[100]),),
                    Text(
                      MenuItemCode.restoreFileBackup.label,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ),
              PopupMenuItem<int>(
                value: MenuItemCode.deleteAllBooksInLibreria.cd, 
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(right: 10.0), child: Icon(Icons.delete, color: Colors.red),),
                    Text(
                      MenuItemCode.deleteAllBooksInLibreria.label.replaceFirst('{0}', Constant.libreriaInUso!.nome),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ),
              PopupMenuItem<int>(
                value: MenuItemCode.deleteAllBooksInAllLibrerie.cd, 
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(right: 10.0), child:  Icon(Icons.sentiment_very_dissatisfied_outlined, color: Color.fromARGB(255, 245, 28, 28),),),
                    Text(
                      MenuItemCode.deleteAllBooksInAllLibrerie.label,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ),
          ];
      },
      onSelected: (value) {
        if (value == MenuItemCode.deleteAllBooksInLibreria.cd) {
          libroBloc.add(DeleteAllLibriLibreriaEvent(Constant.libreriaInUso!));
        } 
        else if(value == MenuItemCode.exportAllBooksLibreria.cd) {
          _exportLibriLibreria(context, libroBloc);
        }
        // else if(value == MenuItemCode.importaBooksInLibreria.cd) {
        //   importaLibriInLibreria(context, libroBloc);
        // }
        else if(value == MenuItemCode.restoreFileBackup.cd) {
          _fnRestoreFileBackup(context, libroBloc);
        }
        else if(value == MenuItemCode.deleteAllBooksInAllLibrerie.cd) {
          libroBloc.add(const DeleteAllLibriEvent());
        }
      }
    );
  }

  Future<bool?> _exportLibriLibreria(BuildContext context, LibroBloc libroBloc) async {
    if (context.mounted) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Procedo con l'esportazione di nr.${Constant.nrLibriInLibreriaInUso} libri di ${Constant.libreriaInUso!.nome} ?"),
            actions: <Widget>[
              TextButton(
                child: const Text('Si'),
                onPressed: () {
                  libroBloc.add(ExportAllLibriLibreriaEvent(Constant.libreriaInUso!));
                  Navigator.pop(context, true);
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        },
      );
    }
    
    return false;
  }

  Widget _blocBody(BuildContext context) {
    LibroBloc libroBloc = context.read<LibroBloc>();
    
    return BlocListener<LibroBloc, LibroState> (
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
        },
      )
    );
  }

  /// Gestione Andata/Ritorno alla/dalla pagina di Gestione File di Backup
  /// 
  _fnRestoreFileBackup(BuildContext context, LibroBloc libroBloc) async {
    await Navigator.pushNamed<dynamic> (context, ImportExportFile.pagePath);

    if (context.mounted) {
      libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!));
    }
  }

  Widget widgetListaLibriDataBase(BuildContext context, LibroBloc libroBloc, List<LibroViewModel> lstLibroViewModel) {
    return LibreriaListaLibriWidget(context, libroBloc, lstLibroViewModel, _viewEditLibro, _deleteLibro);
  }

  _searchBookByBarcode(BuildContext context) async {
    LibroBloc libroBloc = context.read<LibroBloc>();
    AppBarBloc appBarBloc = context.read<AppBarBloc>();

    List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode( await LibroSearchService.scanBarcodeNormal()); //** OK */
    // List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode('9788804680604'); // !!! TEST !!!
    // List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode('PIPPO'); // !!! TEST !!!

    if (lstLibroViewModel.isEmpty) {
      if (context.mounted) {
        _openModalBottomSheet(context, libroBloc, appBarBloc);
      }
    } else {
      if (context.mounted) {
        _viewDettaglioLibro(context, libroBloc, lstLibroViewModel.first);
      }
    }
  }

  _viewEditLibro(BuildContext context, LibroBloc libroBloc, LibroViewModel libroViewModel) async {
    String immagineCopertinaPre = libroViewModel.immagineCopertina;
    LibroDettaglioResult? ret = await LibroUtils.viewDettaglioLibro(context, Constant.libreriaInUso!, libroViewModel, true);
    String immagineCopertinaPost = libroViewModel.immagineCopertina;

    if (ret != null) {
      if (ret.isDelete) {
        libroBloc.add(DeleteLibroEvent(Constant.libreriaInUso!, ret.libroViewModel));
      } else if (ret.isInsert) {
        libroBloc.add(EditLibroEvent(Constant.libreriaInUso!, ret.libroViewModel));
      }
    } else if (immagineCopertinaPre != immagineCopertinaPost) {
      libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!));
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

  void _openModalBottomSheet(BuildContext context, LibroBloc libroBloc, AppBarBloc appBarBloc) {
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
                        child: NewLibroWidget(libroBloc, appBarBloc), 
                      ),
                    )
              ],
            ),
        ),
      )
    );
  }
}

  



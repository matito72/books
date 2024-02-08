import 'package:backdrop/backdrop.dart';
import 'package:books/config/com_area.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/features/libro/data/services/db_libro_isar.service.dart';
import 'package:books/features/list_items_select/bloc/list_items_select.bloc.dart';
import 'package:books/features/list_items_select/bloc/list_items_select_events.bloc.dart';
import 'package:books/features/list_items_select/bloc/list_items_select_state.bloc.dart';
import 'package:books/features/libreria/bloc/libreria_state.bloc.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/features/libro/bloc/libro_state.bloc.dart';
import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/injection_container.dart';
import 'package:books/models/libro_isar_to_save.module.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:books/pages/back_drop_lista_libri.dart';
import 'package:books/pages/import_export_file.dart';
import 'package:books/pages/libreria_lista_libri_page.dart';
import 'package:books/pages/lista_libri_groupby.dart';
import 'package:books/pages/ricerca_avanzata.dart';
import 'package:books/resources/action_result.dart';
import 'package:books/resources/bisac_codes.dart';
import 'package:books/services/libro_search_service.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/utilities/list_items_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/appbar/libri_libreria_appbar.dart';
import 'package:books/widgets/new_libro_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

///
/// Pagina con la lista dei libri della libreria selezionata
///
enum MenuItemCode {
  newBookInLibreria(5, "Inserisci un nuovo Libro"),
  exportAllBooksLibreria(10, "Crea file backup"),
  restoreFileBackup(25, "Gestione files backup"),
  deleteAllBooksInLibreria(0, "Elimina tutti i libri: '{0}'"),
  deleteNrBooksFromList(30, 'Elimina i libri selezionati'),
  switchSearchToUserInsert(35, "Attiva inserimento manuale"),
  switchUserToSearchInsert(40, "Attiva inserimento automatico"),
  // deleteAllBooksInAllLibrerie(30, "Elimina TUTTI i Libri."),
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
    return PopScope(
      canPop: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LibroBloc>(
            create: (_) => LibroBloc(sl<DbLibroIsarService>())..add(InitLibroEvent()),
          ),
          BlocProvider<ListItemsSelectBloc>(
            create: (_) => ListItemsSelectBloc()..add(InitListItemsSelectEvent()),
          ),
        ],
        child: BlocBuilder<LibroBloc, LibroState>(
          builder: (context, state) {
            return _getMainScaffold(context);
          }
        )
      ),
    );
  }

  _getMainScaffold(BuildContext context) {
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);

    return BackdropScaffold(
      headerHeight: 40,
      resizeToAvoidBottomInset: true,
      frontLayerShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0), 
          topRight: Radius.circular(0)
        )
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: BackdropAppBar(
                title: LibriLibreriaAppBar(libroBloc), 
                toolbarHeight: 35,
                leadingWidth: (MediaQuery.of(context).size.width * 7 / 100),
                actions: [ _createAppBarPopupMenuButton(context) ],
                flexibleSpace: Container(
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Color.fromARGB(255, 33, 44, 49), Colors.blue],
                      tileMode: TileMode.clamp,
                      begin: Alignment.centerLeft,
                    ),
                  ),
                )
              ),
            ),
          ]
        ),
      ),
      backLayer: _createBackLayer(context),
      frontLayer: _blocBody(context),
      floatingActionButton: _createFloatingActionButtonBloc(context),
      stickyFrontLayer: true,
    );
  }

  Widget _createFloatingActionButtonBloc(BuildContext context) {
    return BlocListener<ListItemsSelectBloc, ListItemsSelectState> (
      listener: (context, ListItemsSelectState state) {
        // ...
      },
      child: BlocBuilder<ListItemsSelectBloc, ListItemsSelectState> (
        builder: (context, state) {
          if (state is ListItemsInsertByUserState) {
            ComArea.isBarcode = false;
          } else if (state is ListItemsInsertByBarcoreState) {
            ComArea.isBarcode = true;
          }

          return createFloatingActionButton(context, state.nrItemSel, state.isAllSel);
        },
      )
    );
  }

  Widget createFloatingActionButton(BuildContext context, int? nrItemSel, bool? isAllSel) {
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);

    if (nrItemSel == 0) {
      // DEFAULT
      if (ComArea.isBarcode) {
        return FloatingActionButton(
          backgroundColor: const Color.fromARGB(176, 0, 97, 100),
          onPressed: () => _searchBookByBarcode(context),
          child: Icon(
            MdiIcons.barcodeScan,
            color: Theme.of(context).colorScheme.onSecondary,
          ),        
        );
      } else {
        return FloatingActionButton(
          backgroundColor: const Color.fromARGB(176, 0, 97, 100),
          onPressed: () => _fnNewBookInLibreria(context, libroBloc),
          child: Icon(
            MdiIcons.bookPlus,
            color: Theme.of(context).colorScheme.onSecondary,
          ),        
        );
      }
      
    } else {
      // CHECK-ALL
      return FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(176, 0, 97, 100),
        onPressed: () => {
          (isAllSel == true) 
            ? libroBloc.add(DeCheckAllLibroEvent(libroBloc.state.data))
            : libroBloc.add(CheckAllLibroEvent(libroBloc.state.data)),
        },
        label: Text(
          'Nr. sel. ${nrItemSel.toString()}',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary,)
        ),
        icon: Icon(
          (isAllSel == true) 
            ? MdiIcons.selectionOff 
            : Icons.done_all_outlined, 
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      );
    }
  }

  _createBackLayer(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 100 / 100),
      height: (MediaQuery.of(context).size.height * 40 / 100),
      child : ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,item)=> buildCardHorizontal(context, item+1),
        separatorBuilder: (context,item)=> const SizedBox(height: 5,),
        itemCount: 2
      ),
    );
  }

  Widget buildCardHorizontal(BuildContext context, int nr) {    
    LibroBloc libroBloc = context.read<LibroBloc>();

    if (nr == 1) {
      return BackDropListaLibri(libroBloc);
    } 

    // return RicercaAvanzata(libroBloc);
    return _createRicercaAvanzataBloc(context);
  }

  Widget _createRicercaAvanzataBloc(BuildContext context) {
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);
    RicercaAvanzata ricercaAvanzata = RicercaAvanzata(libroBloc, ComArea.lstLibrerieInUso);
    
    return BlocListener<LibroBloc, LibroState> (
      listener: (context, LibroState state) {
        if (state.actionResult != null && state.msg != null) {
          // GESTIONE MESSAGGI OK e d'ERRORE         
        }
        if (state is AddedNewLibroState || state is EditLibroState || state is DeletedLibroState ||
            state is LibroInitializedState || state is DeleteAllLibroState) {
          // ...
        } 
      },
      child: BlocBuilder<LibroBloc, LibroState> (
        // ...
        builder: (context, state) {
          if (state is LibroWaitingState) {
            // ...
          }

          if (state is ListaLibroLoadedState) {
            // ...
          } 
          
          if (state is LibroErrorState) {
            // ...
          }

          return ricercaAvanzata;
        },
      )
    );
  }

  PopupMenuButton _createAppBarPopupMenuButton(BuildContext context) {
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);
    ListItemsSelectBloc listItemsSelectBloc = BlocProvider.of<ListItemsSelectBloc>(context);

    return PopupMenuButton(
      padding: EdgeInsets.zero,
      offset: const Offset(0, 35),
      elevation: 20,
      splashRadius: 200,
      shadowColor: Colors.blueGrey[800],
      surfaceTintColor: Colors.blueGrey[700],
      color: const Color.fromARGB(224, 88, 136, 182),
      shape: RoundedRectangleBorder(
        side: BorderSide.lerp(BorderSide.none, BorderSide.none, 12),
        borderRadius: BorderRadius.circular(12),
      ),
      icon: const Icon(Icons.more_vert, color: Colors.white),
      itemBuilder: (context) {
        return _getPopUpMenuItem(libroBloc);
      },
      onSelected: (value) {
        if (value == MenuItemCode.deleteAllBooksInLibreria.cd) {
          _fnDeleteAllBooksLibreria(context, libroBloc);
          // libroBloc.add(DeleteAllLibriLibreriaEvent(ComArea.libreriaInUso!));
        } 
        else if(value == MenuItemCode.newBookInLibreria.cd) {
          _fnNewBookInLibreria(context, libroBloc);
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
        // else if(value == MenuItemCode.deleteAllBooksInAllLibrerie.cd) {
        //   libroBloc.add(const DeleteAllLibriEvent());
        // }
        else if(value == MenuItemCode.deleteNrBooksFromList.cd) {
          _fnDeleteNrBooksFromList(context, libroBloc);
        }
        else if(value == MenuItemCode.switchSearchToUserInsert.cd) {
          _fnSwitchSearchToUserInsert(context, libroBloc, listItemsSelectBloc);
        }
        else if(value == MenuItemCode.switchUserToSearchInsert.cd) {
          _fnSwitchUserToSearchInsert(context, libroBloc, listItemsSelectBloc);
        }
      }
    );
  }

  List<PopupMenuItem> _getPopUpMenuItem(LibroBloc libroBloc) {
    return [
      PopupMenuItem<int>(
        value: MenuItemCode.newBookInLibreria.cd, 
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 10.0), child: Icon(MdiIcons.bookPlus , color: Colors.lightBlueAccent),),
            Text(
              MenuItemCode.newBookInLibreria.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ),
      PopupMenuItem<int>(
        value: MenuItemCode.exportAllBooksLibreria.cd, 
        enabled: (ComArea.lstLibrerieInUso.length == 1 && ComArea.nrLibriInLibreriaInUso != 0),
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 10.0), child: Icon(Icons.save_alt, color: Colors.green[100]),),
            Text(
              MenuItemCode.exportAllBooksLibreria.label.replaceFirst('{0}', ComArea.libreriaInUso!.nome),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ),
      PopupMenuItem<int>(
        value: MenuItemCode.restoreFileBackup.cd, 
        enabled: (ComArea.lstLibrerieInUso.length == 1),
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
        value: MenuItemCode.switchSearchToUserInsert.cd, 
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 10.0), child: Icon(MdiIcons.bookPlus, color: Colors.deepPurple),),
            Text(
              MenuItemCode.switchSearchToUserInsert.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ),
      PopupMenuItem<int>(
        value: MenuItemCode.switchUserToSearchInsert.cd, 
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 10.0), child: Icon(MdiIcons.barcodeScan, color: Colors.orange[400]),),
            Text(
              MenuItemCode.switchUserToSearchInsert.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ),
      PopupMenuItem<int>(
        value: MenuItemCode.deleteAllBooksInLibreria.cd, 
        enabled: (ComArea.lstLibrerieInUso.length == 1 && ComArea.nrLibriInLibreriaInUso != 0),
        child: Row(
          children: [
            const Padding(padding: EdgeInsets.only(right: 10.0), child: Icon(Icons.delete, color: Color.fromARGB(255, 216, 94, 86)),),
            Text(
              MenuItemCode.deleteAllBooksInLibreria.label.replaceFirst('{0}', Utils.getFirstSubstring(ComArea.libreriaInUso!.nome, 10)),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ),
      PopupMenuItem<int>(
        value: MenuItemCode.deleteNrBooksFromList.cd, 
        enabled: (ListItemsUtils.countSelectedItems(libroBloc.state.data) != 0),
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 10.0), child: Icon(Icons.delete_forever, color: Colors.pink[100]),),
            Text(
              MenuItemCode.deleteNrBooksFromList.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ),
      // PopupMenuItem<int>(
      //   value: MenuItemCode.deleteAllBooksInAllLibrerie.cd, 
      //   child: Row(
      //     children: [
      //       const Padding(padding: EdgeInsets.only(right: 10.0), child:  Icon(Icons.sentiment_very_dissatisfied_outlined, color: Color.fromARGB(255, 245, 28, 28),),),
      //       Text(
      //         MenuItemCode.deleteAllBooksInAllLibrerie.label,
      //         style: const TextStyle(fontWeight: FontWeight.bold),
      //       )
      //     ],
      //   )
      // ),
    ];
  }

  /// Elimina i libri selezionati
  /// 
  Future<bool?> _fnDeleteNrBooksFromList(BuildContext context, LibroBloc libroBloc) async {
    int nrLibriSel = ListItemsUtils.countSelectedItems(libroBloc.state.data);

    if (context.mounted) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Procedo con l'eliminazione di nr.$nrLibriSel libri selezionati ?"),
            actions: <Widget>[
              TextButton(
                child: const Text('Si'),
                onPressed: () {
                  libroBloc.add(DeleteBookSelectedEvent(ListItemsUtils.getSelectedItems(libroBloc.state.data)));
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

  _fnSwitchSearchToUserInsert(BuildContext context, LibroBloc libroBloc, ListItemsSelectBloc listItemsSelectBloc) {
    listItemsSelectBloc.add(SwitchSearchToUserInsertEvent());
  }

  _fnSwitchUserToSearchInsert(BuildContext context, LibroBloc libroBloc, ListItemsSelectBloc listItemsSelectBloc) {
    listItemsSelectBloc.add(SwitchUserToSearchInsertEvent());
  }

  /// Elimina TUTTI i libri della Libreria
  /// 
  Future<bool?> _fnDeleteAllBooksLibreria(BuildContext context, LibroBloc libroBloc) async {
    if (context.mounted) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Procedo con l'eliminazione TUTTI i libri della libreria ${ComArea.libreriaInUso!.nome} ?"),
            actions: <Widget>[
              TextButton(
                child: const Text('Si'),
                onPressed: () {
                  libroBloc.add(DeleteAllLibriLibreriaEvent(ComArea.libreriaInUso!));
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

  /// Inserisce un Nuovo libro in Libreria
  /// 
  Future<void> _fnNewBookInLibreria(BuildContext context, LibroBloc libroBloc) async {
    LibroIsarModel libroViewModel = LibroIsarModel(
      ComArea.libreriaInUso!.sigla, 
      Utils.getDataNow(), 
      Utils.getDataNow(), 
      isbn: Utils.getIsbnGenAutoNotNull(),
      lstCategoria: [BisacList.nonClassifiable]
      );
    _viewNewEditLibro(context, libroBloc, libroViewModel, false, showDelete: false, isInsertByUserInterface: true);
  }

  Future<bool?> _exportLibriLibreria(BuildContext context, LibroBloc libroBloc) async {
    if (context.mounted) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Procedo con l'esportazione di nr.${ComArea.nrLibriVisibiliInLista} libri di ${ComArea.libreriaInUso!.nome} ?"),
            actions: <Widget>[
              TextButton(
                child: const Text('Si'),
                onPressed: () {
                  libroBloc.add(ExportAllLibriLibreriaEvent(ComArea.libreriaInUso!));
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
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);
    
    return BlocListener<LibroBloc, LibroState> (
      listener: (context, LibroState state) {
        if (state.actionResult != null && state.msg != null && (state.actionResult != ActionResult.success)) {
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
            state is LibroInitializedState || state is DeleteAllLibroState || state is DeleteBookSelectedState) {
          libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
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
            ListItemsSelectBloc listItemsSelectBloc = BlocProvider.of<ListItemsSelectBloc>(context);
            listItemsSelectBloc.add(RefreshListItemsSelectEvent(libroBloc.state.data));

            return _widgetListaLibriDataBase(context, libroBloc, listItemsSelectBloc, state.data);
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
      libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
    }
  }

  Widget _widgetListaLibriDataBase(BuildContext context, LibroBloc libroBloc, ListItemsSelectBloc floatingButtonBloc, List<SelectedItem<LibroIsarModel>> lstSelectedItem) {
    if (ComArea.showOrderBy) {
      return LibreriaListaLibriPage(context, libroBloc, floatingButtonBloc, lstSelectedItem, _viewNewEditLibro, _deleteLibro);
    } else {
      return ListaLibriGroupBy(context, libroBloc, floatingButtonBloc, lstSelectedItem, _viewNewEditLibro, _deleteLibro);
    }
  }

  _searchBookByBarcode(BuildContext context) async {
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);

    List<LibroIsarModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode( await LibroSearchService.scanBarcodeNormal()); //** OK */
    // List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode('9788807033247'); //('9788807014956') // ('9788804680604'); // !!! TEST !!!
    // List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode('8852023372'); // !!! TEST !!!
    // List<LibroViewModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode('8852071938');
    // 8852071938, 8852071938

    if (lstLibroViewModel.isEmpty) {
      if (context.mounted) {
        _openModalBottomSheet(context, libroBloc);
      }
    } else {
      if (context.mounted) {
        LibroIsarModel libroViewModelDett = lstLibroViewModel.first;
        
        await Utils.integrazioneDatiIncompleti(libroViewModelDett);

        if (context.mounted) {
          _viewDettaglioLibro(context, libroBloc, libroViewModelDett);
        }
      }
    }
  }

  _viewNewEditLibro(BuildContext context, LibroBloc libroBloc, LibroIsarModel libroViewModel, bool isEdit, {bool showDelete = true, bool isInsertByUserInterface = false}) async {
    int siglaLibreriaOld = libroViewModel.siglaLibreria;
    LibroIsarModel libroViewModelClone = libroViewModel.clonaLibro();
    libroViewModelClone.id = libroViewModel.id;
    String immagineCopertinaPre = libroViewModel.immagineCopertina;
    LibroDettaglioResult? ret = await LibroUtils.viewDettaglioLibro(context, ComArea.libreriaInUso!, libroViewModelClone, showDelete, isInsertByUserInterface);
    String immagineCopertinaPost = libroViewModelClone.immagineCopertina;

    if (ret != null) {
      if (ret.isDelete) {
        libroBloc.add(DeleteLibroEvent(ComArea.libreriaInUso!, ret.libroViewModel));
      } else if (ret.isInsert) {
        LibroIsarToSaveModel libroToSaveModel = LibroIsarToSaveModel(ret.libroViewModel, siglaLibreriaOld: siglaLibreriaOld);
        if (isEdit) {
          libroBloc.add(EditLibroEvent(ComArea.libreriaInUso!, libroToSaveModel));
        } else {
          libroBloc.add(AddLibroEvent(ComArea.libreriaInUso!, libroToSaveModel));
        }
      }
    } else if (immagineCopertinaPre != immagineCopertinaPost) {
      libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
    }
  }

  _viewDettaglioLibro(BuildContext context, LibroBloc libroBloc, LibroIsarModel libroViewModel) async {
    int siglaLibreriaOld = libroViewModel.siglaLibreria;
    LibroDettaglioResult? libroDettaglioResult = await LibroUtils.viewDettaglioLibro(context, ComArea.libreriaInUso!, libroViewModel, false, true);

    if (libroDettaglioResult != null && libroDettaglioResult.isInsert) {
      LibroIsarToSaveModel libroToSaveModel = LibroIsarToSaveModel(libroDettaglioResult.libroViewModel, siglaLibreriaOld: siglaLibreriaOld);
      libroBloc.add(AddLibroEvent(ComArea.libreriaInUso!, libroToSaveModel));
    }
  }

  _deleteLibro(BuildContext context, LibroBloc libroBloc, LibroIsarModel libroViewModel) async {
    String lbl = libroViewModel.titolo.isNotEmpty 
      ? libroViewModel.titolo
      : libroViewModel.lstAutori.isNotEmpty 
        ? libroViewModel.lstAutori[0] 
        : 'selezionato';
    bool? isDelete = await DialogUtils.showConfirmationSiNo(context, "Elimino il libro\n '$lbl' \ndalla libreria ?");
    
    if (isDelete != null && isDelete) {
      libroBloc.add(DeleteLibroEvent(ComArea.libreriaInUso!, libroViewModel));
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
                        child: NewLibroWidget(libroBloc), 
                      ),
                    )
              ],
            ),
        ),
      )
    );
  }
}

  



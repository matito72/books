import 'dart:async';
import 'dart:io' show Platform;

import 'package:backdrop/backdrop.dart';
import 'package:book/config/com_area.dart';
import 'package:book/features/libreria/bloc/libreria_state.bloc.dart';

import 'package:book/features/libro/bloc/libro.bloc.dart';
import 'package:book/features/libro/bloc/libro_events.bloc.dart';
import 'package:book/features/libro/bloc/libro_state.bloc.dart';
import 'package:book/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/link_isar.module.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/features/libro/data/services/db_libro_isar.service.dart';
import 'package:book/features/list_items_select/bloc/list_items_select.bloc.dart';
import 'package:book/features/list_items_select/bloc/list_items_select_events.bloc.dart';
import 'package:book/features/list_items_select/bloc/list_items_select_state.bloc.dart';
import 'package:book/injection_container.dart';
import 'package:book/models/libro_isar_to_save.module.dart';
import 'package:book/models/selected_item.module.dart';
import 'package:book/pages/back_drop_lista_libri.dart';
import 'package:book/pages/import_export_file.dart';
import 'package:book/pages/libreria_lista_libri_page.dart';
import 'package:book/pages/lista_libri_groupby.dart';
import 'package:book/pages/ricerca_avanzata.dart';
import 'package:book/resources/action_result.dart';
import 'package:book/resources/bisac_codes.dart';
import 'package:book/services/libro_search_service.dart';
import 'package:book/utilities/dialog_utils.dart';
import 'package:book/utilities/libro_utils.dart';
import 'package:book/utilities/list_items_utils.dart';
import 'package:book/utilities/utils.dart';
import 'package:book/widgets/appbar/libri_libreria_appbar.dart';
import 'package:book/widgets/new_libro_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:book/widgets/libreria_sel_dropdown.dart';

///
/// Pagina con la lista dei libri della libreria selezionata
///
enum MenuItemCode {
  deleteAllBooksInLibreria(0, "Elimina tutti i libri: '{0}'"),
  newBookInLibreria(5, "Inserisci un nuovo Libro"),
  exportAllBooksLibreria(10, "Crea file backup"),
  restoreFileBackup(25, "Gestione files backup"),
  deleteNrBooksFromList(30, 'Elimina i libri selezionati'),
  switchSearchToUserInsert(35, "Attiva inserimento manuale"),
  switchUserToSearchInsert(40, "Attiva inserimento automatico"),
  cambiaLibreria(45, "Cambia Libreria ai libri selezionati"),
  exportInExcel(50, "Esporta in Excel"),
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
    ScrollController controller = ScrollController();
    List<SelectedItem<LibroIsarModel>> dataPrec = [];

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
            return _getMainScaffold(context, dataPrec, controller);
          }
        )
      ),
    );
  }

  BackdropScaffold _getMainScaffold(BuildContext context, List<SelectedItem<LibroIsarModel>> dataPrec, ScrollController controller) {
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
      backLayer: _createBackLayer(context, controller),
      frontLayer: _blocBody(context, dataPrec),
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

          return _createFloatingActionButton(context, state.nrItemSel, state.isAllSel);
        },
      )
    );
  }

  Widget _createFloatingActionButton(BuildContext context, int? nrItemSel, bool? isAllSel) {
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);

    if (nrItemSel == 0) {
      // DEFAULT
      if (ComArea.isBarcode) {
        return FloatingActionButton(
          backgroundColor: const Color.fromARGB(176, 0, 97, 100),
          onPressed: () => _searchBookByBarcode(context),
          child: Icon(
            (Platform.isAndroid || Platform.isIOS) ? MdiIcons.barcodeScan : MdiIcons.bookSearch,
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

  SizedBox _createBackLayer(BuildContext context, ScrollController controller) {
    return SizedBox(
      // width: (MediaQuery.of(context).size.width * 100 / 100),
      width: double.infinity,
      height: (MediaQuery.of(context).size.height * 40 / 100),
      child: Scrollbar(
        controller: controller,
        thumbVisibility: (!Platform.isAndroid && !Platform.isIOS) ? false : true,
        child: ListView.separated(
            controller: controller,
            scrollDirection: Axis.horizontal,
            // itemBuilder: (context, item) => _buildCardHorizontal(context, item + 1),
            itemBuilder: (context, index) {
              if (index == 0) {
                LibroBloc libroBloc = context.read<LibroBloc>();
                return BackDropListaLibri(libroBloc);
              }
              return _createRicercaAvanzataBloc(context);
            },
            separatorBuilder: (context,item)=> const SizedBox(height: 5,),
            itemCount: 2
        ),
      ),
    );
  }

  Widget _buildCardHorizontal(BuildContext context, int nr) {
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
        }
        else if (value == MenuItemCode.newBookInLibreria.cd) {
          _fnNewBookInLibreria(context, libroBloc);
        }
        else if (value == MenuItemCode.exportAllBooksLibreria.cd) {
          _exportLibriLibreria(context, libroBloc);
        }
        else if (value == MenuItemCode.exportInExcel.cd) {
          _exportInExcel(context, libroBloc);
        }
        else if (value == MenuItemCode.restoreFileBackup.cd) {
          _fnRestoreFileBackup(context, libroBloc);
        }
        else if (value == MenuItemCode.deleteNrBooksFromList.cd) {
          _fnDeleteNrBooksFromList(context, libroBloc);
        }
        else if (value == MenuItemCode.cambiaLibreria.cd) {
          _fnCambiaLibreria(context, libroBloc);
        }
        else if (value == MenuItemCode.switchSearchToUserInsert.cd) {
          _fnSwitchSearchToUserInsert(context, libroBloc, listItemsSelectBloc);
        }
        else if (value == MenuItemCode.switchUserToSearchInsert.cd) {
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
      ComArea.isBarcode
        ? PopupMenuItem<int>(
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
          )
        : PopupMenuItem<int>(
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
      PopupMenuItem<int>(
          value: MenuItemCode.cambiaLibreria.cd,
          enabled: (ListItemsUtils.countSelectedItems(libroBloc.state.data) != 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.swap_horiz_outlined,
                  color: Colors.lightBlueAccent[100],
                ),
              ),
              // L'Expanded costringe il testo a stare nello spazio rimanente
              Expanded(
                child: Text(
                  MenuItemCode.cambiaLibreria.label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  // Opzionale: aggiunge "..." se il testo è ancora troppo lungo per le righe a disposizione
                  overflow: TextOverflow.ellipsis,
                  // Opzionale: decidi quante righe massime mostrare prima di tagliare
                  maxLines: 2,
                ),
              ),
            ],
          )
      ),
      PopupMenuItem<int>(
          value: MenuItemCode.exportInExcel.cd,
          enabled: true, // (ListItemsUtils.countSelectedItems(libroBloc.state.data) != 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  MdiIcons.fileExcel,
                  color: Colors.lightGreen,
                ),
              ),
              // L'Expanded costringe il testo a stare nello spazio rimanente
              Expanded(
                child: Text(
                  MenuItemCode.exportInExcel.label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  // Opzionale: aggiunge "..." se il testo è ancora troppo lungo per le righe a disposizione
                  overflow: TextOverflow.ellipsis,
                  // Opzionale: decidi quante righe massime mostrare prima di tagliare
                  maxLines: 2,
                ),
              ),
            ],
          )
      ),
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
            title: Text(
                "Procedo con l'eliminazione di nr.$nrLibriSel libri selezionati ?",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.limeAccent,
                )
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.amber[200],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  libroBloc.add(DeleteBookSelectedEvent(ListItemsUtils.getSelectedItems(libroBloc.state.data)));
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    }
    
    return false;
  }

  Future<bool?> _fnCambiaLibreria(BuildContext context, LibroBloc libroBloc) async {
    int nrLibriSel = ListItemsUtils.countSelectedItems(libroBloc.state.data);
    int siglaLibreriaNew =  ComArea.libreriaInUso!.sigla;

    if (context.mounted) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: (nrLibriSel == 1)
            ? Text(
              "Procedo al cambio di Libreria al libro selezionato ?",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.limeAccent,
              ))
            : Text(
              "Procedo al cambio di Libreria ai $nrLibriSel libri selezionati ?",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.limeAccent,
              )),
            actions: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Libreria',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.amberAccent[700],
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  LibreriaSelDropdown(
                    -1,
                    onPressed: (value) {
                      siglaLibreriaNew = value;
                    },
                  ),
              ],),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.amber[200],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                  TextButton(
                    child: Text(
                        'OK',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.lightGreenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      libroBloc.add(CambiaLibreriaBookSelectedEvent(ListItemsUtils.getSelectedItems(libroBloc.state.data), siglaLibreriaNew));
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              )
            ],
          );
        },
      );
    }

    return false;
  }

  void _fnSwitchSearchToUserInsert(BuildContext context, LibroBloc libroBloc, ListItemsSelectBloc listItemsSelectBloc) {
    listItemsSelectBloc.add(SwitchSearchToUserInsertEvent());
  }

  void _fnSwitchUserToSearchInsert(BuildContext context, LibroBloc libroBloc, ListItemsSelectBloc listItemsSelectBloc) {
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
            title: Text(
              "Procedo con l'eliminazione TUTTI i libri della libreria ${ComArea.libreriaInUso!.nome} ?",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.limeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.amber[200],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  libroBloc.add(DeleteAllLibriLibreriaEvent(ComArea.libreriaInUso!));
                  Navigator.pop(context, true);
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
            title: Text(
              "Procedo con l'esportazione di nr.${ComArea.nrLibriVisibiliInLista} libri di ${ComArea.libreriaInUso!.nome} ?",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.limeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.amber[200],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  libroBloc.add(ExportAllLibriLibreriaEvent(ComArea.libreriaInUso!));
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    }
    
    return false;
  }

  Future<bool?> _exportInExcel(BuildContext context, LibroBloc libroBloc) async {
    if (context.mounted) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Procedo con l'esportazione in Excel di nr.${ComArea.nrLibriVisibiliInLista} libri ?",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.limeAccent,
                fontWeight: FontWeight.bold,
              ),),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.amber[200],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  libroBloc.add(ExportInExcelEvent(ComArea.lstLibrerieInUso));
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    }

    return false;
  }

  Widget _blocBody(BuildContext context, List<SelectedItem<LibroIsarModel>> dataPrec) {
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);

    return BlocListener<LibroBloc, LibroState> (
      listener: (context, LibroState state) {
        if (state.actionResult != null && state.msg != null && (state is LibroStopDownloadExcelState || (state.actionResult != ActionResult.success))) {
          if (state is! LibreriaLoadedState && state is! LibroInitializedState) {
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
            state is LibroInitializedState || state is DeleteAllLibroState || state is DeleteBookSelectedState ||
            state is CambiaLibreriaBookSelectedState // || state is ExportedFileExcelState
        ) {
          libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
        } else  if (state is ExportedFileState) {
          _fnRestoreFileBackup(context, libroBloc);
        }
      },
      child: BlocBuilder<LibroBloc, LibroState>(
        builder: (context, state) {
          bool isLibroStartDownloadExcelState = state is LibroStartDownloadExcelState; // ComArea.isLibroStartDownloadExcel;

          if (state is LibroWaitingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ListaLibroLoadedState || isLibroStartDownloadExcelState || state is LibroStopDownloadExcelState) {
            ListItemsSelectBloc listItemsSelectBloc = BlocProvider.of<ListItemsSelectBloc>(context);
            // listItemsSelectBloc.add(RefreshListItemsSelectEvent(libroBloc.state.data));

            // var listaDati = (state is ListaLibroLoadedState) ? state.data : dataPrec; // libroBloc.state.data;
            if (state is ListaLibroLoadedState) {
              // ListItemsSelectBloc listItemsSelectBloc = BlocProvider.of<ListItemsSelectBloc>(context);
              listItemsSelectBloc.add(RefreshListItemsSelectEvent(libroBloc.state.data));
              dataPrec.clear();
              dataPrec.addAll(state.data);
            }
            var listaDati = dataPrec;

            return Stack(
              children: [
                IgnorePointer(
                  // Disabilita le interazioni quando il download è attivo
                  ignoring: isLibroStartDownloadExcelState,
                  child: AnimatedOpacity(
                    // Valore dell'opacità con transizione fluida
                    opacity: isLibroStartDownloadExcelState ? 0.2 : 1.0,
                    duration: const Duration(milliseconds: 300), // Durata dell'animazione
                    curve: Curves.easeInOut, // Tipo di curva di animazione
                    child: _widgetListaLibriDataBase(context, libroBloc, listItemsSelectBloc, listaDati),
                  ),
                ),
                // Mostriamo il caricamento solo se necessario
                if (isLibroStartDownloadExcelState)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
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
  Future<void> _fnRestoreFileBackup(BuildContext context, LibroBloc libroBloc) async {
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

  Future<void> _searchBookByBarcode(BuildContext context) async {
    bool isSmartPhone = (Platform.isAndroid || Platform.isIOS);
    LibroBloc libroBloc = BlocProvider.of<LibroBloc>(context);

    List<LibroIsarModel> lstLibroViewModel = [];
    if (isSmartPhone) {
      String scannedCode = await LibroSearchService.scanBarcodeNormal(context);
      lstLibroViewModel = await LibroSearchService.searchBooksByBarcode(scannedCode);
    }

    // List<LibroIsarModel> lstLibroViewModel = await LibroSearchService.searchBooksByBarcode( await LibroSearchService.scanBarcodeNormal(context)); //** OK */
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

  Future<void> _viewNewEditLibro(BuildContext context, LibroBloc libroBloc, LibroIsarModel libroViewModel, bool isEdit, {bool showDelete = true, bool isInsertByUserInterface = false}) async {
    int siglaLibreriaOld = libroViewModel.siglaLibreria;
    String isbnLibroOld = libroViewModel.isbn;
    
    final DbLibroIsarService dbLibroService = sl<DbLibroIsarService>();
    LibroIsarModel? libroViewModelDb = await dbLibroService.getLibroById(libroViewModel.id, siglaLibreria: libroViewModel.siglaLibreria);
    if (!context.mounted) {
      return;
    }
    // String hashLibroDb = (libroViewModelDb != null) ? libroViewModelDb.calcolaHash() : "";
    LibroIsarModel libroViewModelClone = (libroViewModelDb != null) ? libroViewModelDb.clonaLibro() : libroViewModel.clonaLibro();
    libroViewModelClone.id = libroViewModel.id;
    List<LinkIsarModule> lstLinkIsarModule = (libroViewModelDb != null) ? libroViewModelDb.lstLinkIsarModule.toList() : [];
    List<PdfIsarModule> lstPdfIsarModule = (libroViewModelDb != null) ? libroViewModelDb.lstPdfIsarModule.toList() : [];
    String immagineCopertinaPre = libroViewModel.immagineCopertina;
    LibroDettaglioResult? ret = await LibroUtils.viewDettaglioLibro(context, ComArea.libreriaInUso!, libroViewModelClone, lstLinkIsarModule, lstPdfIsarModule, showDelete, isInsertByUserInterface);
    String immagineCopertinaPost = libroViewModelClone.immagineCopertina;

    if (ret != null) {
      if (ret.isDelete) {
        libroBloc.add(DeleteLibroEvent(ComArea.libreriaInUso!, ret.libro));
      } else if (ret.isInsert) {
        LibroIsarToSaveModel libroToSaveModel = LibroIsarToSaveModel(
          ret.libro, 
          siglaLibreriaOld: siglaLibreriaOld, 
          isbnLibroOld: isbnLibroOld, 
          lstLinkIsarModule: ret.lstLinkIsarModule,
          lstPdfIsarModule: ret.lstPdfIsarModule
        );
        if (isEdit) {
          libroBloc.add(EditLibroEvent(ComArea.libreriaInUso!, libroToSaveModel));
        } else {
          libroBloc.add(AddLibroEvent(ComArea.libreriaInUso!, libroToSaveModel));
        }
      }
    }
    else if (immagineCopertinaPre != immagineCopertinaPost) {
      libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
    }
  }

  Future<void> _viewDettaglioLibro(BuildContext context, LibroBloc libroBloc, LibroIsarModel libroViewModel) async {
    int siglaLibreriaOld = libroViewModel.siglaLibreria;
    LibroDettaglioResult? libroDettaglioResult = await LibroUtils.viewDettaglioLibro(context, ComArea.libreriaInUso!, libroViewModel, [], [], false, true);

    if (libroDettaglioResult != null && libroDettaglioResult.isInsert) {
      LibroIsarToSaveModel libroToSaveModel = LibroIsarToSaveModel(libroDettaglioResult.libro, siglaLibreriaOld: siglaLibreriaOld);
      libroBloc.add(AddLibroEvent(ComArea.libreriaInUso!, libroToSaveModel));
    }
  }

  Future<void> _deleteLibro(BuildContext context, LibroBloc libroBloc, LibroIsarModel libroViewModel) async {
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





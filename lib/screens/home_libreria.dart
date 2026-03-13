// import 'dart:io';

import 'package:book/config/com_area.dart';
import 'package:book/config/constant.dart';
import 'package:book/features/libreria/bloc/libreria.bloc.dart';
import 'package:book/features/libreria/bloc/libreria_events.bloc.dart';
import 'package:book/features/libreria/bloc/libreria_state.bloc.dart';
import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:book/features/libreria/data/services/db_libreria.isar.service.dart';
// import 'package:book/features/libro/bloc/libro_state.bloc.dart';
import 'package:book/injection_container.dart';
import 'package:book/models/selected_item.module.dart';
import 'package:book/models/widget_desc.module.dart';
import 'package:book/resources/action_result.dart';
import 'package:book/utilities/dialog_utils.dart';
import 'package:book/utilities/list_items_utils.dart';
import 'package:book/widgets/appbar/appbar_default.dart';
import 'package:book/widgets/form_libreria_new.dart';
import 'package:book/widgets/single_card_libreria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

///
/// Pagina con la lista delle librerie salvate
///
class HomeLibreriaScreen extends StatelessWidget {
  final Function()? _fn;

  const HomeLibreriaScreen({Function()? fn, super.key}) : _fn = fn;

  Future<void> _addNewLibreria(BuildContext context) async {
    FormLibreriaNew f = FormLibreriaNew(
      WidgetDescModel('Nome libreria:', '', maxLines: 1),
    );
    String? nomeLibreria = await f.getMultiDescrizione(context);

    if (nomeLibreria != null && nomeLibreria.isNotEmpty) {
      LibreriaIsarModel libreriaIsarModelNew = LibreriaIsarModel(
        nome: nomeLibreria,
      );

      if (context.mounted) {
        BlocProvider.of<LibreriaBloc>(
          context,
        ).add(AddLibreriaEvent(libreriaIsarModelNew));
      }
    }
  }

  Future<void> _editLibreria(
    BuildContext context,
    LibreriaIsarModel libreria,
  ) async {
    List<WidgetDescModel> lstWidgetDescModel = [
      WidgetDescModel('Nome libreria:', libreria.nome, maxLines: 1),
      WidgetDescModel(
        'Sigla libreria:',
        libreria.sigla.toString(),
        maxLines: 1,
        readOnly: true,
      ),
    ];
    String? strDesc = await DialogUtils.getMultiDescrizione(
      context,
      lstWidgetDescModel,
    );
    if (strDesc != null &&
        strDesc.contains(';') &&
        strDesc.split(';').length == 2) {
      LibreriaIsarModel libreriaModelNew = LibreriaIsarModel(
        nome: strDesc.split(';')[0].trim(),
        nrLibriCaricati: libreria.nrLibriCaricati,
      );

      if (context.mounted) {
        BlocProvider.of<LibreriaBloc>(context).add(EditLibreriaEvent(libreria, libreriaModelNew));
      }
    }
  }

  Future<void> _saveLibreria(BuildContext context, LibreriaIsarModel libreria) async {
    if (context.mounted) {
      BlocProvider.of<LibreriaBloc>(context).add(SaveLibreriaEvent(libreria));
    }
  }

  Future<void> _deleteLibreria(
    BuildContext context,
    LibreriaIsarModel libreria,
  ) async {
    bool? isDeleteLibreria = await DialogUtils.showConfirmationSiNo(
      context,
      "Vuoi eliminare la seguente libreria\n\n Nome: '${libreria.nome}'\n\nCod.: ${libreria.sigla}'\n\n con [${libreria.nrLibriCaricati}] libri caricati ?",
    );
    if (context.mounted && isDeleteLibreria != null && isDeleteLibreria) {
      BlocProvider.of<LibreriaBloc>(context).add(DeleteLibreriaEvent(libreria));
    }
  }

  void _goToHomeLibriLibreria(BuildContext context, LibreriaIsarModel? libreriaIsarModelSel) async {
    if (_fn != null) {
      LibreriaBloc libreriaBloc = BlocProvider.of<LibreriaBloc>(context);

      if (context.mounted) {
        if (libreriaIsarModelSel != null) {
          ComArea.libreriaInUso = libreriaIsarModelSel;
          ComArea.lstLibrerieInUso = ListItemsUtils.getSelectedListItems(libreriaBloc.state.data);
          // ComArea.mapCodDescLibreria = Utils.getMapCodDescLibreria(ComArea.lstLibrerieInUso);
        }
        await _fn();
        if (context.mounted) {
          BlocProvider.of<LibreriaBloc>(context).add(const LoadLibreriaEvent());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewLibreria(context),
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      body: _blocBody(context),
    );
  }

  AppBarDefault _buildAppbar(BuildContext context) {
    return AppBarDefault(
      context: context,
      txtLabel: '${Constant.titoloApp} - Librerie',
      showIconSx: false,
    );
  }

  Widget _widgetListaLibrerie(
      BuildContext context,
      List<SelectedItem<LibreriaIsarModel>> lstSelectedItem) {
    // 1. Definisci il Future
    Future<List<LibreriaIsarModel>> futureLibrerie = sl<DbLibreriaIsarService>().readLstLibreriaFromDb();

    return FutureBuilder<List<LibreriaIsarModel>>(
      future: futureLibrerie,
      builder: (BuildContext context, AsyncSnapshot<List<LibreriaIsarModel>> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Errore: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<LibreriaIsarModel> lstLibreriaViewModel = snapshot.data!;
          LibreriaBloc libreriaBloc = BlocProvider.of<LibreriaBloc>(context);

          if (ComArea.lstLibrerieInUso.isNotEmpty) {
            for (SelectedItem<LibreriaIsarModel> selItem in lstSelectedItem) {
              LibreriaIsarModel? libreriaCheck = lstLibreriaViewModel
                  .cast<LibreriaIsarModel?>()
                  .firstWhere(
                    (element) => element!.sigla == selItem.item.sigla,
                orElse: () => null,
              );

              if (libreriaCheck != null) {
                selItem.item.nrLibriCaricati = libreriaCheck.nrLibriCaricati;
                selItem.item.valoreTot = libreriaCheck.valoreTot;
              }
            }
          }
          // === FINE LOGICA ===

          return Center(
            widthFactor: 1,
            child: lstSelectedItem.isEmpty
                ? Center(
                    child: Text(
                      'Nessuna Libreria presente',
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                    ) // const Text('Nessuna Libreria presente'),
                  )
                : ListView(
              children: lstSelectedItem.map((selectedItem) {
                return SingleCardLibreria(
                  libreriaBloc,
                  selectedItem,
                  _goToHomeLibriLibreria,
                  _editLibreria,
                  _deleteLibreria,
                  _saveLibreria
                );
              }).toList(),
            )
          );
        }
        // Stato di default
        return const SizedBox.shrink();
      },
    );
  }

  Widget _blocBody(BuildContext context) {
    return BlocListener<LibreriaBloc, LibreriaState>(
      listener: (BuildContext context, LibreriaState state) {
        if (state.actionResult != null && state.msg != null) {
          if (state is! LibreriaLoadedState ||
              state.actionResult != ActionResult.success) {
            // --------------------------------------------------------
            // GESTIONE MESSAGGI UTENTE
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
              ),
            );
          }
        }
        if (state is AddedNewLibreriaState ||
            state is DeleteAllLibreriaState ||
            state is DeleteLibreriaState ||
            state is LibreriaInitializedState ||
            state is EditLibreriaState) {
          BlocProvider.of<LibreriaBloc>(context).add(const LoadLibreriaEvent());
        }
      },
      child: BlocBuilder<LibreriaBloc, LibreriaState>(
        // bloc: sl<LibreriaBloc>(),
        builder: (context, state) {
          if (state is LibreriaWaitingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LibreriaLoadedState) {
            return _widgetListaLibrerie(context, state.data);
          }
          if (state is LibreriaErrorState) {
            return Center(child: Text("Error: ${state.msg}"));
          }

          debugPrint(
            'AAAAAAAAAAAHHHHHHHHHHHHHHHHH !!!!!!!!!!!!!!!!!!!!!!!!!!! ${state.toString()}',
          );

          return Container();
        },
      ),
    );
  }
}

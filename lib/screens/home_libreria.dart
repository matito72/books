import 'package:books/features/libreria/blocs/libreria_bloc.dart';
import 'package:books/features/libreria/blocs/libreria_events.dart';
import 'package:books/features/libreria/blocs/libreria_state.dart';
import 'package:books/features/libreria/data/models/libreria_model.dart';
import 'package:books/models/widget_desc_model.dart';
import 'package:books/resources/action_result.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/app_bar/app_bar_default.dart';
import 'package:books/widgets/form_libreria_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../config/constant.dart';

/// 
/// Pagina con la lista delle librerie salvate
/// 
class HomeLibreriaScreen extends StatelessWidget {
  final Function? fn;
  
  const HomeLibreriaScreen({this.fn, super.key});
  
  _addNewLibreria(BuildContext context) async {
    FormLibreriaNew f = FormLibreriaNew(WidgetDescModel('Nome libreria:', '', maxLines:1), WidgetDescModel('Sigla libreria:', '', maxLines:1));
    String? strDesc = await f.getMultiDescrizione(context);
    //List<WidgetDescModel> lstWidgetDescModel = [WidgetDescModel('Nome libreria:', '', maxLines:1), WidgetDescModel('Sigla libreria:', '', maxLines:1)];
    //String? strDesc = await DialogUtils.getMultiDescrizione(context, lstWidgetDescModel);

    if (strDesc != null && strDesc.contains(';') && strDesc.split(';').length == 2) {
      LibreriaModel libreriaModelNew = LibreriaModel(nome: strDesc.split(';')[0].trim(), sigla: strDesc.split(';')[1].trim().toUpperCase());
      
      if (context.mounted) {
        BlocProvider.of<LibreriaBloc>(context).add(AddLibreriaEvent(libreriaModelNew));
      }
    }
  }

  _editLibreria(BuildContext context, LibreriaModel libreria) async {
    List<WidgetDescModel> lstWidgetDescModel = [
      WidgetDescModel('Nome libreria:', libreria.nome, maxLines:1), 
      WidgetDescModel('Sigla libreria:', libreria.sigla, maxLines:1, readOnly: true)
    ];
    String? strDesc = await DialogUtils.getMultiDescrizione(context, lstWidgetDescModel);
    if (strDesc != null && strDesc.contains(';') && strDesc.split(';').length == 2) {
      LibreriaModel libreriaModelNew = LibreriaModel(
        nome: strDesc.split(';')[0].trim(), 
        sigla: strDesc.split(';')[1].trim().toUpperCase(),
        nrLibriCaricati: libreria.nrLibriCaricati
      );
      
      if (context.mounted) {
        BlocProvider.of<LibreriaBloc>(context).add(EditLibreriaEvent(libreria, libreriaModelNew));
      }
    }
  }

  _deleteLibreria(BuildContext context, LibreriaModel libreria) async {
    bool? isDeleteLibreria = await DialogUtils.showConfirmationSiNo(context, "Vuoi eliminare la libreria:\n\n '${libreria.sigla} - ${libreria.nome}'\n\n con [${libreria.nrLibriCaricati}] libri caricati ?");
    if (context.mounted && isDeleteLibreria != null && isDeleteLibreria) {
      BlocProvider.of<LibreriaBloc>(context).add(DeleteLibreriaEvent(libreria));
    }
  }

  void _goToHomeLibriLibreria(BuildContext context, LibreriaModel libreria) async {
    if (fn != null) {
      await fn!(libreria);
      if (context.mounted) {
        BlocProvider.of<LibreriaBloc>(context).add(const LoadLibreriaEvent());
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewLibreria(context),
        child: const Icon(Icons.add),
      ),
      body: _blocBody(context),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBarDefault(
      context: context,
      txtLabel: '${Constant.titoloApp} - Librerie',
      showIconSx: false,
      popupMenuButton: PopupMenuButton(
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
        padding: EdgeInsets.zero,
        itemBuilder: (context){
          return [
                // PopupMenuItem<int>(value: 1, child: Text("Settings")),
                // PopupMenuItem<int>(value: 2,child: Text("Logout")),
                const PopupMenuItem<int>(
                  value: 0, 
                  child: Row(
                    children: [
                      Icon(Icons.sentiment_very_dissatisfied_outlined),
                      Padding(padding: EdgeInsets.only(right: 15.0)),
                      Text("Cancella tutte le librerie !")
                    ],
                  )
                ),
            ];
        },
        onSelected:(value){
          if (value == 0) {
            BlocProvider.of<LibreriaBloc>(context).add(DeleteAllLibreriaEvent());
          } 
          // else if(value == 1){print("Settings menu is selected.");}
          // else if(value == 2){print("Logout menu is selected.");}
        }
      ),
    );
  }

  Widget _widgetListaLibrerie(BuildContext context, List<LibreriaModel> lstLibreriaModel) {
    LibreriaModel? libreriaInUso = Constant.libreriaInUso;

    if (libreriaInUso != null && lstLibreriaModel.isNotEmpty) {
      for (var libreria in lstLibreriaModel) {
        // debugPrint('==============================> ${libreriaInUso.nome}');
        if (libreria.sigla == libreriaInUso.sigla) {
          // libreria = libreriaInUso!;
          libreria.nrLibriCaricati = libreriaInUso.nrLibriCaricati;
        } 
      }
    }
    
    return Center(
      child: lstLibreriaModel.isEmpty
        ? const Text('Nessuna Libreria presente')
        : ListView(
            children: lstLibreriaModel.map((libreria) {
              return Card(
                shadowColor: const Color.fromARGB(139, 48, 63, 159),
                surfaceTintColor: libreria.isLibreriaDefault ? Colors.green.shade100 : Colors.transparent,
                // color: (dbLibreriaService.libreriaInUso.nome == libreria.nome) ? Colors.cyan.shade800 : Colors.transparent,
                color: libreria.isLibreriaDefault ? const Color.fromARGB(103, 0, 131, 143) : Colors.transparent,
                // color: Colors.transparent,
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  style: ListTileStyle.list,
                  leading: Padding(
                      padding: const EdgeInsets.all(3),
                      child: FittedBox(
                        child: CircleAvatar(
                          radius: 30,
                          child: Text(libreria.sigla,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.blue.shade900,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold)),
                        ),
                      )
                    ),
                  title: (!Constant.initApp) 
                    ? Text(libreria.nome)
                    : (libreriaInUso != null && libreriaInUso.sigla == libreria.sigla) ? Text('[ ${libreria.nome} ]') : Text(libreria.nome),
                  // title: Text(libreria.nome),
                  // title: libreria.isLibreriaDefault ? Text('${libreria.nome} - default') : Text(libreria.nome),
                  subtitle: Text(
                    'Libri: ${libreria.nrLibriCaricati}'
                  ),
                  trailing: Wrap(
                    // spacing: 0,
                    children: [
                      IconButton(
                        icon: (Constant.initApp && libreriaInUso != null && libreriaInUso.sigla == libreria.sigla) 
                          ? const Icon(MdiIcons.doorOpen, color: Colors.green,)
                          : const Icon(MdiIcons.doorClosed, color: Colors.green,),
                        onPressed: () => {_goToHomeLibriLibreria(context, libreria)},
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.yellowAccent.shade100,),
                        onPressed: () => {_editLibreria(context, libreria)},
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.orange.shade800),
                        onPressed: () => {_deleteLibreria(context, libreria)},
                      ),
                    ], 
                  ),
                ),
              );
            }).toList(),
          ),
      );
  }
  
  Widget _blocBody(BuildContext context) {
    return BlocListener<LibreriaBloc, LibreriaState>(
        listener: (BuildContext context, LibreriaState state) {
          if (state.actionResult != null && state.msg != null) {
            if (state is! LibreriaLoadedState || state.actionResult != ActionResult.success) {
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
                )
              );
            }
          }
          if (state is AddedNewLibreriaState || state is DeleteAllLibreriaState || state is DeleteLibreriaState ||
              state is LibreriaInitializedState || state is EditLibreriaState) {
            BlocProvider.of<LibreriaBloc>(context).add(const LoadLibreriaEvent());
          } 
        },
        child: BlocBuilder<LibreriaBloc, LibreriaState>(
          // bloc: sl<LibreriaBloc>(),
          builder: (context, state) {
            if (state is LibreriaWaitingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LibreriaLoadedState) {
              return _widgetListaLibrerie(context, state.data);
            } 
            if (state is LibreriaErrorState) {
              return Center(child:  Text("Error: ${state.msg}"));
            }
            
            debugPrint('AAAAAAAAAAAHHHHHHHHHHHHHHHHH !!!!!!!!!!!!!!!!!!!!!!!!!!! ${state.toString()}');

            return Container();
          },
        )
      );
  }  
}
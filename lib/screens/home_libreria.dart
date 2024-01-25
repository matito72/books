// import 'dart:io';

import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/bloc/libreria.bloc.dart';
import 'package:books/features/libreria/bloc/libreria_events.bloc.dart';
import 'package:books/features/libreria/bloc/libreria_state.bloc.dart';
import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:books/models/widget_desc.module.dart';
import 'package:books/resources/action_result.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/list_items_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/appbar/appbar_default.dart';
import 'package:books/widgets/form_libreria_new.dart';
import 'package:books/widgets/single_card_libreria.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/constant.dart';
// import 'dart:convert' show utf8;

/// 
/// Pagina con la lista delle librerie salvate
/// 
class HomeLibreriaScreen extends StatelessWidget {
  final Function()? _fn;
  
  const HomeLibreriaScreen({Function()? fn, super.key}) : _fn = fn;
  
  _addNewLibreria(BuildContext context) async {
    FormLibreriaNew f = FormLibreriaNew(WidgetDescModel('Nome libreria:', '', maxLines:1));
    String? nomeLibreria = await f.getMultiDescrizione(context);

    if (nomeLibreria != null && nomeLibreria.isNotEmpty) {
      LibreriaModel libreriaModelNew = LibreriaModel(nome: nomeLibreria, sigla: Utils.getDataNow());
      
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
    bool? isDeleteLibreria = await DialogUtils.showConfirmationSiNo(context, "Vuoi eliminare la seguente libreria\n\n Nome: '${libreria.nome}'\n\nCod.: ${libreria.sigla}'\n\n con [${libreria.nrLibriCaricati}] libri caricati ?");
    if (context.mounted && isDeleteLibreria != null && isDeleteLibreria) {
      BlocProvider.of<LibreriaBloc>(context).add(DeleteLibreriaEvent(libreria));
    }
  }

  void _goToHomeLibriLibreria(BuildContext context, LibreriaModel? libreriaModelSel) async {
    if (_fn != null) {
      LibreriaBloc libreriaBloc = BlocProvider.of<LibreriaBloc>(context);
      // await _fn!();
      if (context.mounted) {
        if (libreriaModelSel != null) {
          ComArea.libreriaInUso = libreriaModelSel;
          ComArea.lstLibrerieInUso = ListItemsUtils.getSelectedListItems(libreriaBloc.state.data);
          ComArea.mapCodDescLibreria = Utils.getMapCodDescLibreria(ComArea.lstLibrerieInUso);
        }
        await _fn!();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewLibreria(context),
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary
        ),
      ),
      body: _blocBody(context),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBarDefault(
      context: context,
      txtLabel: '${Constant.titoloApp} - Librerie',
      showIconSx: false,
      // popupMenuButton: PopupMenuButton(
      //   // add icon, by default "3 dot" icon
      //   // icon: Icon(Icons.book)
      //   padding: EdgeInsets.zero,
      //   itemBuilder: (context) {
      //     return [
      //           // PopupMenuItem<int>(value: 1, child: Text("Settings")),
      //           const PopupMenuItem<int>(
      //             value: 0, 
      //             child: Row(
      //               children: [
      //                 Icon(Icons.sentiment_very_dissatisfied_outlined),
      //                 Padding(padding: EdgeInsets.only(right: 15.0)),
      //                 Text("Cancella tutte le librerie !")
      //               ],
      //             )
      //           ),
      //           const PopupMenuItem<int>(
      //             value: 1, 
      //             child: Row(
      //               children: [
      //                 Icon(Icons.sentiment_very_dissatisfied_outlined),
      //                 Padding(padding: EdgeInsets.only(right: 15.0)),
      //                 Text("TEST....")
      //               ],
      //             )
      //           ),
      //       ];
      //   },
      //   onSelected:(value){
      //     if (value == 0) {
      //       BlocProvider.of<LibreriaBloc>(context).add(DeleteAllLibreriaEvent());
      //     } 
      //     else if(value == 1) {
      //       _test();
      //     }
      //     // else if(value == 2){print("Logout menu is selected.");}
      //   }
      // ),
    );
  }

  // _test() async {
  //   // https://drive.google.com/file/d/1qDwEQfPSyfq8Th_UbG3mPsCk6G2mfuOT/view?usp=sharing
  //   // https://drive.google.com/file/d/1qDwEQfPSyfq8Th_UbG3mPsCk6G2mfuOT/view?usp=sharing
  //   // https://drive.google.com/uc?export=download&id=1qDwEQfPSyfq8Th_UbG3mPsCk6G2mfuOT

  //   // https://drive.google.com/file/d/1qDwEQfPSyfq8Th_UbG3mPsCk6G2mfuOT/view%3Fusp=sharing
  //   // debugPrint(await http.read(Uri.https('drive.google.com', '/file/d/1qDwEQfPSyfq8Th_UbG3mPsCk6G2mfuOT/view', { 'usp' : 'sharing' })));

  //   String url = 'https://drive.google.com/uc?export=download&id=1qDwEQfPSyfq8Th_UbG3mPsCk6G2mfuOT';
  //   var httpClient = HttpClient();

  //   var request = await httpClient.getUrl(Uri.parse(url));
  //   var response = await request.close();
    
  //   var bytes = await consolidateHttpClientResponseBytes(response);
  //   var decoded = utf8.decode(bytes);
  //   // String dir = (await getApplicationDocumentsDirectory()).path;
  //   // File file = new File('$dir/$filename');
  //   // await file.writeAsBytes(bytes);
  //   debugPrint(decoded);
  // }

  Widget _widgetListaLibrerie(BuildContext context, List<SelectedItem<LibreriaModel>> lstSelectedItem) {
    LibreriaBloc libreriaBloc = BlocProvider.of<LibreriaBloc>(context);
    // LibreriaModel? libreriaInUso = ComArea.libreriaInUso;
    // if (libreriaInUso != null && lstSelectedItem.isNotEmpty) {
    //   for (var selectedItem in lstSelectedItem) {
    //     // debugPrint('==============================> ${libreriaInUso.nome}');
    //     if (selectedItem.item.sigla == libreriaInUso.sigla) {
    //       // libreria = libreriaInUso!;
    //       selectedItem.item.nrLibriCaricati = libreriaInUso.nrLibriCaricati;
    //     } 
    //   }
    // }
    if (ComArea.lstLibrerieInUso.isNotEmpty) {
      for (SelectedItem<LibreriaModel> selItem in lstSelectedItem) {
        LibreriaModel? libreriaCheck = ComArea.lstLibrerieInUso.cast<LibreriaModel?>().firstWhere((element) => element!.sigla == selItem.item.sigla, orElse: () => null);
        if (libreriaCheck != null) {
          selItem.item.nrLibriCaricati = libreriaCheck.nrLibriCaricati;
        }
      }
    }
    
    return Center(
      child: lstSelectedItem.isEmpty
        ? const Text('Nessuna Libreria presente')
        : ListView(
            children: lstSelectedItem.map((selectedItem) {
              return SingleCardLibreria(libreriaBloc, selectedItem, _goToHomeLibriLibreria, _editLibreria, _deleteLibreria);
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
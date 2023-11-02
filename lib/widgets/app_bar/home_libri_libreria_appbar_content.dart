import 'package:books/config/constant.dart';
import 'package:books/features/libro/blocs/libro_bloc.dart';
import 'package:books/features/libro/blocs/libro_events.dart';
import 'package:books/features/libro/blocs/libro_state.dart';
import 'package:books/screens/home_libri_libreria.dart';
import 'package:books/widgets/app_bar/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeLibriLibreriaAppBarContent extends StatelessWidget {
  final Function fnRestoreFileBackup;
  final LibroBloc libroBloc;

  const HomeLibriLibreriaAppBarContent(this.libroBloc, this.fnRestoreFileBackup, {super.key});

  @override
  Widget build(BuildContext context) {    
    return Row(
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(left: 10)),
        BlocBuilder<LibroBloc, LibroState>(
          builder: (context, state) {
            return Text(
                'Libreria ${Constant.libreriaInUso!.nome}: ${Constant.libreriaInUso!.nrLibriCaricati} libri',
                style: const TextStyle(color: Colors.white),
              );            
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.search, size: 20,),
          color: Colors.white,
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
        _createAppBarPopupMenuButton(context, libroBloc)
      ],
    );
  }

  PopupMenuButton _createAppBarPopupMenuButton(BuildContext context, LibroBloc libroBloc) {
    return PopupMenuButton(
      // add icon, by default "3 dot" icon
      // icon: Icon(Icons.book)
      itemBuilder: (context) {
        return [
              PopupMenuItem<int>(value: MenuItemCode.deleteAllBooksInLibreria.cd, child: Text(MenuItemCode.deleteAllBooksInLibreria.label.replaceFirst('{0}', Constant.libreriaInUso!.nome))),
              PopupMenuItem<int>(value: MenuItemCode.exportAllBooksLibreria.cd, child: Text(MenuItemCode.exportAllBooksLibreria.label.replaceFirst('{0}', Constant.libreriaInUso!.nome))),
              // PopupMenuItem<int>(value: MenuItemCode.importaBooksInLibreria.cd, child: Text(MenuItemCode.importaBooksInLibreria.label)),
              PopupMenuItem<int>(value: MenuItemCode.restoreFileBackup.cd, child: Text(MenuItemCode.restoreFileBackup.label)),
              PopupMenuItem<int>(value: MenuItemCode.deleteAllBooksInAllLibrerie.cd, child: Text(MenuItemCode.deleteAllBooksInAllLibrerie.label)),
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
          fnRestoreFileBackup(context, libroBloc);
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
}
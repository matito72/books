import 'package:books/config/com_area.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/models/books_search_parameters.module.dart';
import 'package:books/widgets/appbar/backdrop_appbar_default.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LibriLibreriaAppBar extends StatefulWidget {
  final LibroBloc _libroBloc;
  
  const LibriLibreriaAppBar(this._libroBloc, {super.key});

  @override
  State<LibriLibreriaAppBar> createState() => _LibriLibreriaAppbarState();
}

class _LibriLibreriaAppbarState extends State<LibriLibreriaAppBar> {
    TextEditingController textCtrlSearch = TextEditingController(); // SEARCH

  @override
  Widget build(BuildContext context) {

    return _createAppBar(textCtrlSearch);
  }

  Widget _createAppBar(TextEditingController textCtrlSearch) {
    return BackdropAppbarDefault(
      context: context,
      showIconSx: false,
      appBarContent: ComArea.appBarStateText 
        ? _createTextTitle(context, textCtrlSearch)
        : _createTextSearch(context, textCtrlSearch)
      // appBarContent: BlocBuilder<LibroBloc, LibroState>(
      //   builder: (context, state) {
      //     if (appBarBloc.state is TextAppBarState) {
      //       return _createTextTitle(context, textCtrlSearch);
      //     }
      //     return _createTextSearch(context, textCtrlSearch);
      //   }      
      // ),
    );
  }

  Widget _createTextTitle(BuildContext context, TextEditingController textCtrlSearch) {
    // LABEL : default
    textCtrlSearch.clear();
    if (ComArea.bookToSearch.isNotEmpty) {
      widget._libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
    }
    ComArea.bookToSearch = '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap:() {
            setState(() {
              ComArea.appBarStateText = false;
            });
            // if (appBarBloc.state is SearchAppBarState) {
            //   appBarBloc.add(SwithToTextAppBarEvent());
            // } else if (appBarBloc.state is TextAppBarState) {
            //   appBarBloc.add(SwithToSearchAppBarEvent());
            // }
          },
          child: Text(
            getTextAppbar(),
            style: const TextStyle(
              color: Colors.white, fontSize: 16
            ),
          )
        ),
        (ComArea.nrLibriVisibiliInLista != ComArea.libreriaInUso!.nrLibriCaricati)
        ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Padding(padding: EdgeInsets.only(left: 5)),
            IconButton(
              icon: Icon(
                MdiIcons.eraser, 
                size: 20,
              ),
              alignment: Alignment.center,
              visualDensity: VisualDensity.compact,
              onPressed: () => {
                setState(() {
                  setState(() {
                    ComArea.booksSearchParameters = BooksSearchParameters(
                      txtTitolo: '', 
                      txtAutore: '', 
                      txtEditore: '',
                      txtCategoria: '',
                      txtAnnoPubblicazioneDa: '', 
                      txtAnnoPubblicazioneA: '',
                      txtPrezzoMin: '',
                      txtPrezzoMax: ''
                    );
                    widget._libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
                  });
                })                
              },
            ),
            const Text(
              "Filtro Attivo",
              style: TextStyle(
                color: Colors.white, fontSize: 13
              ),
            )
          ],
        )
        : const Text("")

      ],
    );
  }

  String getTextAppbar() {
    if (ComArea.nrLibriVisibiliInLista == ComArea.libreriaInUso!.nrLibriCaricati) {
      return 'Libreria ${ComArea.libreriaInUso!.nome}: ${ComArea.libreriaInUso!.nrLibriCaricati} libri';
    }

    return 'Libreria ${ComArea.libreriaInUso!.nome}: ${ComArea.nrLibriVisibiliInLista}/${ComArea.libreriaInUso!.nrLibriCaricati} libri';
  }

  Widget _createTextSearch(BuildContext context, TextEditingController textCtrlSearch) {
    return TextField(
      textInputAction: TextInputAction.search,
      controller: textCtrlSearch,
      textAlignVertical: TextAlignVertical.center,
      autofocus: true,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      onSubmitted: (value) {
        ComArea.bookToSearch = textCtrlSearch.text;
        widget._libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 180, 218, 228),
        hintText: 'Search...',
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          color: Colors.black,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.close),
          onPressed: () {                  
            textCtrlSearch.clear();
            ComArea.bookToSearch = '';
            widget._libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
            FocusScope.of(context).unfocus();
            setState(() {
              ComArea.appBarStateText = true;
            });
          },
        ),
        isCollapsed: true,
        isDense: true
      ),
    );
  }
}
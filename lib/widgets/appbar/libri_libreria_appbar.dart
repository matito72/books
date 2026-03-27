import 'dart:io' show Platform;

import 'package:book/config/com_area.dart';
import 'package:book/features/libro/bloc/libro.bloc.dart';
import 'package:book/features/libro/bloc/libro_events.bloc.dart';
import 'package:book/models/books_search_parameters.module.dart';
import 'package:book/utilities/utils.dart';
import 'package:book/widgets/appbar/backdrop_appbar_default.dart';
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
  void dispose() {
    textCtrlSearch.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _createAppBar(textCtrlSearch);
  }

  Widget refreshIconButton() {
    return IconButton(
      icon: Icon(
          MdiIcons.refresh,
          size: 20,
          color: Colors.green
      ),
      alignment: Alignment.center,
      visualDensity: VisualDensity.compact,
      onPressed: () => {
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
          widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
        })
      },
    );
  }

  Widget _createAppBar(TextEditingController textCtrlSearch) {
    return BackdropAppbarDefault(
      context: context,
      showIconSx: false,
      appBarContent: ComArea.appBarStateText
          ? _createTextTitle(context, textCtrlSearch)
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 0.0,
              children: [
                Expanded(
                  child: _createTextSearch(context, textCtrlSearch),
                ),
                refreshIconButton(),
              ],
          ),
    );
  }

  Widget _createTextTitle(BuildContext context, TextEditingController textCtrlSearch) {
    // LABEL : default
    textCtrlSearch.clear();
    if (ComArea.bookToSearch.isNotEmpty) {
      widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
    }
    ComArea.bookToSearch = '';
    bool showFiltroAttivo = (ComArea.nrLibriVisibiliInLista != ComArea.nrLibriInLibreriaInUso);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap:() {
            setState(() {
              ComArea.appBarStateText = false;
            });
          },
          child: Row(
            children: [
              const Icon(Icons.library_books),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Text(
                _getTextAppbar(),
                style: const TextStyle(
                  color: Colors.white, fontSize: 16
                ),
              ),
            ],
          )
        ),
        showFiltroAttivo
            // FITRO ATTIVO
          ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  MdiIcons.eraser, 
                  size: 20,
                  // color: const Color.fromARGB(255, 236, 26, 26)
                  color: Colors.deepOrangeAccent
                ),
                alignment: Alignment.center,
                visualDensity: VisualDensity.compact,
                onPressed: () => {
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
                    widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
                  })                
                },
              ),
              const Text(
                "Reset",
                style: TextStyle(
                  color: Colors.white, fontSize: 13
                ),
              ),
            ],
          )
            // Filtro NON attivo
          : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [ refreshIconButton() ],
        )
      ],
    );
  }

  String _getTextAppbar() {
    int maxNrChar = (!Platform.isAndroid && !Platform.isIOS) ? 150 : 20;
    String spaces = (!Platform.isAndroid && !Platform.isIOS) ? "           => " : ": ";
    String strNomeLibreriaSel = (ComArea.lstLibrerieInUso.isNotEmpty && ComArea.lstLibrerieInUso.length == 1)
      ? Utils.getFirstSubstring(ComArea.libreriaInUso!.nome, maxNrChar)
      : '';
    
    // if (ComArea.nrLibriVisibiliInLista == ComArea.libreriaInUso!.nrLibriCaricati) {
    //   return '$strNomeLibreriaSel: ${ComArea.nrLibriInLibreriaInUso} libri';
    // }

    return '$strNomeLibreriaSel$spaces ${ComArea.nrLibriVisibiliInLista}/${ComArea.nrLibriInLibreriaInUso} libri';
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
        widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
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
            widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
            FocusScope.of(context).unfocus();
            setState(() {
              ComArea.appBarStateText = true;
            });
          },
        ),
        isCollapsed: true,
        isDense: true,
        maintainHintSize: false
      ),
    );
  }
}
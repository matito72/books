import 'package:books/config/constant.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/widgets/appbar/backdrop_appbar_default.dart';
import 'package:flutter/material.dart';

class LibriLibreriaAppBar extends StatefulWidget {
  final LibroBloc libroBloc;
  
  const LibriLibreriaAppBar(this.libroBloc, {super.key});

  @override
  State<LibriLibreriaAppBar> createState() => _LibriLibreriaAppbarState();
}

class _LibriLibreriaAppbarState extends State<LibriLibreriaAppBar> {
    bool appBarStateText = true;  // DEFAULT
    TextEditingController textCtrlSearch = TextEditingController(); // SEARCH

  @override
  Widget build(BuildContext context) {

    return _createAppBar(textCtrlSearch);
  }

  Widget _createAppBar(TextEditingController textCtrlSearch) {
    return BackdropAppbarDefault(
      context: context,
      showIconSx: false,
      appBarContent: appBarStateText 
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
    if (Constant.bookToSearch.isNotEmpty) {
      widget.libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!, Constant.lstBookOrderByDefault));
    }
    Constant.setBookToSearch('');
    return InkWell(
      onTap:() {
        setState(() {
          appBarStateText = false;
        });
        // if (appBarBloc.state is SearchAppBarState) {
        //   appBarBloc.add(SwithToTextAppBarEvent());
        // } else if (appBarBloc.state is TextAppBarState) {
        //   appBarBloc.add(SwithToSearchAppBarEvent());
        // }
      },
      child: Text(
        'Libreria ${Constant.libreriaInUso!.nome}: ${Constant.libreriaInUso!.nrLibriCaricati} libri',
        style: const TextStyle(
          color: Colors.white, fontSize: 16
        ),
      )
    );
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
        Constant.setBookToSearch(textCtrlSearch.text);
        widget.libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!, Constant.lstBookOrderBy));
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
            Constant.setBookToSearch('');
            widget.libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!, Constant.lstBookOrderBy));
            FocusScope.of(context).unfocus();
            setState(() {
              appBarStateText = true;
            });
          },
        ),
        isCollapsed: true,
        isDense: true
      ),
    );
  }
}
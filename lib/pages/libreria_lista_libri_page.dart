import 'package:book/config/com_area.dart';
import 'package:book/config/constant.dart';
import 'package:book/features/libro/bloc/libro.bloc.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/list_items_select/bloc/list_items_select.bloc.dart';
import 'package:book/models/selected_item.module.dart';
import 'package:book/resources/row_item_image.dart';
import 'package:book/widgets/single_card_book.dart';
import 'package:flutter/material.dart';
 
class LibreriaListaLibriPage extends StatelessWidget {
  final BuildContext _parentContext; 
  final LibroBloc _libroBloc;
  final ListItemsSelectBloc _floatingButtonBloc;
  final List<SelectedItem<LibroIsarModel>> _listaLibri;
  final Function(BuildContext, LibroBloc, LibroIsarModel, bool) _fnViewDettaglioLibro;
  final Function _fnDeleteLibro;
  final num _nrTot;

  const LibreriaListaLibriPage(
    this._parentContext, 
    this._libroBloc, 
    this._floatingButtonBloc,
    this._listaLibri, 
    this._fnViewDettaglioLibro, 
    this._fnDeleteLibro,
    {super.key}
  ) : _nrTot = _listaLibri.length;

  // -----------------------------
  // Funziona come LISTA
  // -----------------------------
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: _listaLibri.isEmpty
  //         ? _buildEmptyState(context) // Spostato in un metodo per pulizia
  //         : ListView.builder(
  //             // Rimosso SingleChildScrollView e Column
  //             itemCount: _listaLibri.length,
  //             padding: const EdgeInsets.only(top: 20), // Se ti serve spazio sopra
  //             itemBuilder: (context, index) {
  //               final item = _listaLibri[index];
  //               return SingleCardBook(
  //                 _libroBloc,
  //                 _floatingButtonBloc,
  //                 _parentContext,
  //                 _fnViewDettaglioLibro,
  //                 _fnDeleteLibro,
  //                 getItemImage,
  //                 item,
  //                 index,
  //                 _nrTot,
  //               );
  //             },
  //         ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    //
    // // 2. Definisci il numero di colonne (Esempio: soglia 600px per tablet, 1200px per desktop)
    // int crossAxisCount = 1;
    // if (screenWidth > 1200) {
    //   crossAxisCount = 3;
    // } else if (screenWidth > 600) {
    //   crossAxisCount = 2;
    // }
    //
    // double paddingAndMargin = 20; // margini della card
    // double columnWidth = (screenWidth / crossAxisCount);
    // double cardHeight = 150; // L'altezza totale del tuo widget SingleCardBook
    // double aspectRatio = columnWidth / cardHeight;

    return SafeArea(
      child: _listaLibri.isEmpty
          ? _buildEmptyState(context)
          : GridView.builder(
        padding: const EdgeInsets.all(1),
        itemCount: _listaLibri.length,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // crossAxisCount: crossAxisCount,
        // childAspectRatio: aspectRatio, // Mantiene l'altezza fissa
        // mainAxisSpacing: 5,
        // crossAxisSpacing: 5,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: ComArea.isMobileApp ? double.infinity : 500, // Ogni card non sarà mai più larga di 500px
          mainAxisExtent: 150,     // FORZA l'altezza fissa (molto comodo nel tuo caso!)
          mainAxisSpacing: ComArea.isMobileApp ? 0 : 10,
          crossAxisSpacing: ComArea.isMobileApp ? 0 : 10,
        ),
        itemBuilder: (context, index) {
          return SingleCardBook(
            _libroBloc,
            _floatingButtonBloc,
            _parentContext,
            _fnViewDettaglioLibro,
            _fnDeleteLibro,
            getItemImage,
            _listaLibri[index],
            index,
            _nrTot,
          );
        },
      ),
    );
  }

  // Helper per lo stato vuoto
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          SizedBox(
            height: (MediaQuery.of(context).size.height * 40 / 100),
            child: Image.asset(Constant.assetImageDefault, fit: BoxFit.cover),
          ),
          const Padding(padding: EdgeInsets.all(40.0)),
        ],
      ),
    );
  }

}

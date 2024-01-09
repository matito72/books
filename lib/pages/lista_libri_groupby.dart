import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/list_items_select/bloc/list_items_select.bloc.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:books/resources/row_item_image.dart';
import 'package:books/utilities/ordinamento_libri_utils.dart';
import 'package:books/widgets/single_card_book.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class ListaLibriGroupBy extends StatelessWidget {
  final BuildContext _parentContext; 
  final LibroBloc _libroBloc;
  final ListItemsSelectBloc _floatingButtonBloc;
  final List<SelectedItem<LibroViewModel>> _listaLibri;
  final Function _fnViewDettaglioLibro;
  final Function _fnDeleteLibro;
  final num _nrTot;

  const ListaLibriGroupBy(
    this._parentContext, 
    this._libroBloc,
    this._floatingButtonBloc,
    this._listaLibri, 
    this._fnViewDettaglioLibro, 
    this._fnDeleteLibro,
    {super.key}
  ) : _nrTot = _listaLibri.length;

//   @override
//   State<ListaLibriGroupBy> createState() => _ListaLibriGroupByState();
// }
 
// class _ListaLibriGroupByState extends State<ListaLibriGroupBy> {

  /// Estrae da 'libroViewModel' il valore del campo: 'nameField'
  /// DEFAULT: 'libroViewModel.lstAutori[0];'
  String getValueField(LibroViewModel libroViewModel, String nameField) {
    return OrdinamentoLibriUtils.getLibroViewModelValueByLabel(libroViewModel, nameField);
  }

  int compareValueField(LibroViewModel a, LibroViewModel b) {
    return OrdinamentoLibriUtils.getLibroViewModelValue(a, ComArea.itemComparatorField).compareTo(OrdinamentoLibriUtils.getLibroViewModelValue(b, ComArea.itemComparatorField));
  }

  @override
  Widget build(BuildContext context) {    
    return SafeArea(
      child: _listaLibri.isEmpty
        ? Center(
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height * 50 / 100),
                    child: Image.asset(Constant.assetImageDefault, fit: BoxFit.cover,)
                  ),
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                  ),
                ],
            ),
          )
        : GroupedListView<SelectedItem<LibroViewModel>, String> (
            elements: _listaLibri,
            groupBy: (element) => getValueField(element.item, ComArea.groupComparatorField.label),
            groupComparator: (value1, value2) => value1.compareTo(value2),
            itemComparator: (a, b) => compareValueField(a.item, b.item),
            order: ComArea.orderByAsc ? GroupedListOrder.ASC : GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            floatingHeader: false,
            stickyHeaderBackgroundColor: Colors.blueGrey[900]!,
            groupHeaderBuilder: (element) => ColoredBox(
              color: const Color.fromARGB(224, 88, 136, 182),
              child: Text(
                getValueField(element.item, ComArea.groupComparatorField.label),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.lime[100],
                  backgroundColor: Colors.transparent
                ),
              )
            ),
            indexedItemBuilder: (context, libroViewModel, index) {
              return SingleCardBook(
                _libroBloc, 
                _floatingButtonBloc,
                _parentContext, 
                _fnViewDettaglioLibro, 
                _fnDeleteLibro, 
                getItemImage, 
                libroViewModel, 
                index, 
                _nrTot
              );
            },
          )
    );
  }

}

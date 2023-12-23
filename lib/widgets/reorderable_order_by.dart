import 'package:books/config/com_area.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/resources/ordinamento_libri.dart';
import 'package:flutter/material.dart';

class ReorderableOrderBy extends StatefulWidget {
  final LibroBloc _libroBloc;
  
  const ReorderableOrderBy(this._libroBloc, {super.key});

  @override
  State<ReorderableOrderBy> createState() => _ReorderableOrderByState();
}

class _ReorderableOrderByState extends State<ReorderableOrderBy> {
  final List<OrdinamentoLibri> _items = ComArea.lstBookOrderBy;

  String getLabelOrdinemantoLibri() {
    if (ComArea.orderByAsc) {
      return 'Ordinamento Libri -> Ascendente';
    }
    return 'Ordinamento Libri -> Discendente';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    
    return Expanded(
      flex: 10,
      child: SizedBox(
        height: 150.0,
        child: ReorderableListView(
          buildDefaultDragHandles: false,
          children: <Widget>[
            for (int index = 0; index < _items.length; index++)
              ColoredBox(
                key: Key('$index'),
                color: index.isOdd ? oddItemColor : evenItemColor,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      child: ReorderableDragStartListener(
                        index: index,
                        child: Card(
                          color: colorScheme.primary,
                          elevation: 2,
                          child: Center(
                            child: Text(
                              _items[index].label.substring(0, 1),
                              style: const TextStyle(
                                color: Colors.black, 
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _items[index].label,
                                style: const TextStyle(
                                  // color: Colors.black, 
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                )
                              )
                            ]
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Checkbox(
                                value: _items[index].isSelected,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _items[index].isSelected = newValue!;
                                    widget._libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
                                  });
                                },
                              )
                            ]
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final OrdinamentoLibri item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });

            ComArea.lstBookOrderBy = _items;
            widget._libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
          },
        ),
      ),
    );
  }


  // Widget lstOrderBy(BuildContext context) {
    
  // }
}

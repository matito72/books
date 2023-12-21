// import 'dart:js_util';

import 'package:books/config/constant.dart';
import 'package:books/features/filtro_libri/bloc/filtro_libri.bloc.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:flutter/material.dart';

class ReorderableOrderBy extends StatefulWidget {
  final FiltroLibriBloc filtroLibriBloc;
  final LibroBloc libroBloc;
  
  const ReorderableOrderBy(this.filtroLibriBloc, this.libroBloc, {super.key});

  @override
  State<ReorderableOrderBy> createState() => _ReorderableOrderByState();
}

class _ReorderableOrderByState extends State<ReorderableOrderBy> {
  final List<OrdinamentoLibri> _items = OrdinamentoLibri.values.map((e) => e).toList();  

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    
    return Expanded(
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
                    Text(_items[index].label),
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

            widget.libroBloc.add(LoadLibroEvent(Constant.libreriaInUso!, _items));
          },
        ),
      ),
    );
  }
}

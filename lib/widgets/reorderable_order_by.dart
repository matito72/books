import 'package:books/config/com_area.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/resources/ordinamento_libri.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReorderableOrderBy extends StatefulWidget {
  final LibroBloc libroBloc;
  
  const ReorderableOrderBy(this.libroBloc, {super.key});

  @override
  State<ReorderableOrderBy> createState() => _ReorderableOrderByState();
}

class _ReorderableOrderByState extends State<ReorderableOrderBy> {
  final List<OrdinamentoLibri> _items = ComArea.lstBookOrderBy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 100 / 100),
      height: (MediaQuery.of(context).size.height * 40 / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              getTextOrdinamentoLista(),
              // const Text(' ')
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          lstOrderBy(context),
        ]
      ),
    );
  }

  Widget getTextOrdinamentoLista() {
    TextStyle defaultStyle = TextStyle(color: Colors.grey[200], fontSize: 18);
    TextStyle linkStyle = TextStyle(color: Colors.lightGreen[100]);

    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          const TextSpan(text: 'Ordinamento Libri '),
          TextSpan(
            text: ComArea.orderByAsc ? 'Ascendente' : 'Discendente',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  ComArea.orderByAsc = !ComArea.orderByAsc;
                  widget.libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
                });  
              }
          ),
        ],
      ),
    );
  }

  String getLabelOrdinemantoLibri() {
    if (ComArea.orderByAsc) {
      return 'Ordinamento Libri -> Ascendente';
    }

    return 'Ordinamento Libri -> Discendente';
  }

  Widget lstOrderBy(BuildContext context) {
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
                                    widget.libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
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
            widget.libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
          },
        ),
      ),
    );
  }
}

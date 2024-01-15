
import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/resources/ordinamento_libri.dart';
import 'package:books/widgets/group_by_menu.dart';
import 'package:flutter/material.dart';

class GroupByWidget extends StatefulWidget {
  final LibroBloc _libroBloc;
  final List<LibreriaModel> _lstLibreriaSel;
  
  const GroupByWidget(this._libroBloc, this._lstLibreriaSel, {super.key});

  @override
  State<GroupByWidget> createState() => _GroupByWidgetState();
}

class _GroupByWidgetState extends State<GroupByWidget> {
  TextStyle defaultStyle = TextStyle(color: Colors.grey[200], fontSize: 18);
  TextStyle linkStyle = TextStyle(color: Colors.lightGreen[100]);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 10,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(padding: EdgeInsets.only(top: 0)),
                Text('Raggruppato per: ', style: defaultStyle),
                const Padding(padding: EdgeInsets.only(top: 75, left: 20)),
                Text('Ordinato per: ', style: defaultStyle),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 85, left: 20)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GroupByMenu(
                  initOrdinamentoLibri: ComArea.groupComparatorField,
                  onPressed: (value) {
                    setState(() {
                      ComArea.groupComparatorField = OrdinamentoLibri.byName(value);
                      widget._libroBloc.add(LoadLibroEvent(widget._lstLibreriaSel));
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 55)),
                GroupByMenu(
                  initOrdinamentoLibri: ComArea.itemComparatorField,
                  onPressed: (value) {
                    setState(() {
                      ComArea.itemComparatorField = OrdinamentoLibri.byName(value);
                      widget._libroBloc.add(LoadLibroEvent(widget._lstLibreriaSel));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
import 'package:books/config/com_area.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/widgets/group_by_widget.dart';
import 'package:books/widgets/reorderable_order_by.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BackDropListaLibri extends StatefulWidget {
  final LibroBloc _libroBloc;

  const BackDropListaLibri(this._libroBloc, {super.key});

  @override
  State<BackDropListaLibri> createState() => _BackDropListaLibriState();
}

class _BackDropListaLibriState extends State<BackDropListaLibri> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 100 / 100),
      height: (MediaQuery.of(context).size.height * 35 / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              getHeaderText(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
          ),
          ComArea.showOrderBy 
            ? ReorderableOrderBy(widget._libroBloc, ComArea.lstLibrerieInUso)
            : GroupByWidget(widget._libroBloc, ComArea.lstLibrerieInUso)
        ],
      ),
    );
  }

  Widget getHeaderText() {
    TextStyle defaultStyle = TextStyle(color: Colors.grey[200], fontSize: 18);
    TextStyle linkStyle = TextStyle(color: Colors.lightGreen[100], decoration: TextDecoration.underline,);

    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(
            text: ComArea.showOrderBy ? 'Ordinamento' : 'Raggruppamento',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  ComArea.showOrderBy = !ComArea.showOrderBy;
                  widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
                });  
              }
          ),
          const TextSpan(text: ' Libri '),
          TextSpan(
            text: ComArea.orderByAsc ? 'Ascendente' : 'Discendente',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  ComArea.orderByAsc = !ComArea.orderByAsc;
                  widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
                });  
              }
          ),
        ],
      ),
    );
  }

}

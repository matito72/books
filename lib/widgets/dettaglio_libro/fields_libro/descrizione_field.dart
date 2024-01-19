import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

Widget _getDescrizioneEsistente(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InkWell(
        splashColor: Colors.transparent,
        onDoubleTap: () async {
          String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione);
          if (strDesc != null) {
            fn(strDesc);
          }
        },
        child: Text(
          'Descrizione',
          style: TextStyle(
            fontSize: 14,
            color: Colors.lightBlue.shade100,
            fontWeight: FontWeight.bold
          ),                                          
        ),
      ),
      ExpandableText(
        widget.libroViewModel.descrizione,
        maxLines: 10,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        expandText: '>>',
        collapseText: '<<',
      )
      // ReadMoreText.selectable(
      //   widget._libroViewModel.descrizione,
      //   numLines: 10,
      //   style: const TextStyle(
      //     fontSize: 14,
      //     color: Colors.white,
      //   ),
      //   readMoreTextStyle: TextStyle(color: Colors.blue.shade200,),
      //   readMoreIcon: Icon(Icons.more_horiz, color: Colors.blue.shade200),
      //   readLessIcon: Icon(Icons.keyboard_arrow_up, color: Colors.blue.shade200),
      //   readMoreText: '',
      //   readLessText: '',
      //   cursorColor: Colors.blue.shade200,
      //   cursorRadius: const Radius.circular(1),
      //   readMoreAlign: AlignmentDirectional.topEnd,
      // )
    ],
  );
}

Widget _getDescrizioneDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione);
      if (strDesc != null) {
        fn(strDesc);
      }
    },
    child: Stack(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width * 95 / 100),
          height: (MediaQuery.of(context).size.height * 35 / 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(color: Theme.of(context).colorScheme.background)
            border: Border.all(color: Theme.of(context).colorScheme.inversePrimary)
            // border: Border.all(color: Colors.transparent)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  'Descrizione',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.lightBlue.shade100,
                    fontWeight: FontWeight.bold
                  ),                                          
                ),
              const Text(
                '''
                ''',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            iconSize: 25,
            padding: const EdgeInsets.all(0),
            icon: Icon(
              Icons.edit,
              color: Colors.yellowAccent[700]
            ),
            alignment: Alignment.topRight,
            onPressed: () async {
              String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione);
              if (strDesc != null) {
                fn(strDesc);
              }
            },
          ),
        )
      ],
    ),
  );
}

Widget getDescrizioneField(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  if (widget.libroViewModel.descrizione.isNotEmpty) {
    return _getDescrizioneEsistente(context, widget, fn);
  } 
  
  return _getDescrizioneDaDefinire(context, widget, fn);
}
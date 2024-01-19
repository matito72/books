import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

Widget _getLstAutoriEsistente(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 15),
    child: InkWell(
      splashColor: Colors.transparent,
      onDoubleTap: () async {
        String? strDesc = await DialogUtils.getDescrizione(context, 'Autore:', widget.libroViewModel.lstAutori[0], maxLines: 3);
        if (strDesc != null) {
          fn(strDesc);
        }
      },
      child: ExpandableText(
        widget.libroViewModel.lstAutori.join(', '),
        maxLines: 2,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.white70
        ),
        expandText: '',
        collapseText: '<<',
      ),
    ),
  );
}

Widget _getLstAutoriDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 15),
    child: InkWell(
      splashColor: Colors.transparent,
      onDoubleTap: () async {
        String? strDesc = await DialogUtils.getDescrizione(context, 'Autore:', widget.libroViewModel.lstAutori[0], maxLines: 3);
        if (strDesc != null) {
          fn(strDesc);
        }
      },
      child: Stack(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width * 85 / 100),
            height: (MediaQuery.of(context).size.height * 4 / 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              // border: Border.all(color: Theme.of(context).colorScheme.background)
              border: Border.all(color: Theme.of(context).colorScheme.inversePrimary)
              // border: Border.all(color: Colors.transparent)
            ),
            child: Text(
              ' A U T O R E ',
              maxLines: 2,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.white70
              )
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
                String? strDesc = await DialogUtils.getDescrizione(context, 'Autore:', widget.libroViewModel.lstAutori[0], maxLines: 3);
                if (strDesc != null) {
                  fn(strDesc);
                }
              },
            ),
          )
        ],
      ),
    ),
  );
}

Widget getLstAutoriField(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  if (widget.libroViewModel.lstAutori.isNotEmpty && widget.libroViewModel.lstAutori[0].isNotEmpty) {
    return _getLstAutoriEsistente(context, widget, fn);
  } 
  
  return _getLstAutoriDaDefinire(context, widget, fn);
}
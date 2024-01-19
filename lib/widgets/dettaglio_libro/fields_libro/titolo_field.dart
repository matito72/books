import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:flutter/material.dart';
import 'package:read_more_text/read_more_text.dart';

Widget _getTitoloEsistente(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 15),
    child: _getInkWellOnDoubleTap(context, widget, fn, ReadMoreText.selectable(
      widget.libroViewModel.titolo,
      numLines: 1,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      readMoreTextStyle: TextStyle(color: Colors.amber.shade200),
      readMoreText: '', 
      readLessText: '', 
    ))
  );
}

InkWell _getInkWellOnDoubleTap(BuildContext context, DettaglioLibroWidget widget, Function(String) fn, Widget objChild) {
  return InkWell(
    splashColor: Colors.transparent,
      onDoubleTap: () async {
        String? strDesc = await DialogUtils.getDescrizione(context, 'Titolo:', widget.libroViewModel.titolo, maxLines: 3);
        if (strDesc != null) {
          fn(strDesc);
        }
      },
      child: objChild
  );
}

Widget _getTitoloDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 15),
    child: InkWell(
      splashColor: Colors.transparent,
      onDoubleTap: () async {
        String? strDesc = await DialogUtils.getDescrizione(context, 'Titolo:', widget.libroViewModel.titolo, maxLines: 3);
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
              ' T I T O L O ',
              maxLines: 2,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.white70
              )
            ),
          ),
          Visibility(
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            visible: true,
            child: Align(
              alignment: Alignment.topRight,
              child: ColoredBox(
                color: Colors.transparent,
                child: IconButton(
                  iconSize: 25,
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.yellowAccent[700]
                  ),
                  alignment: Alignment.topRight,
                  onPressed: () async {
                    String? strDesc = await DialogUtils.getDescrizione(context, 'Titolo:', '', maxLines: 3);
                    if (strDesc != null) {
                      fn(strDesc);
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget getTitoloField(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  if (widget.libroViewModel.titolo.isNotEmpty) {
    return _getTitoloEsistente(context, widget, fn);
  } 
  
  return _getTitoloDaDefinire(context, widget, fn);
}
import 'package:books/config/constant.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:flutter/material.dart';
import 'package:read_more_text/read_more_text.dart';

Widget _getEditoreEsistente(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 15),
    child: InkWell(
      splashColor: Colors.transparent,
      onDoubleTap: () async {
        String? strDesc = await DialogUtils.getDescrizione(context, 'Editore:', widget.libroViewModel.editore, maxLines: 2);
        if (strDesc != null) {
          fn(strDesc);
        }
      },
      child: ReadMoreText.selectable(
        widget.libroViewModel.editore,
        numLines: 1,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        readMoreTextStyle: TextStyle(color: Colors.amber.shade200),
        readMoreText: '', 
        readLessText: '', 
      ),
    ),
  );
}

Widget _getEditoreDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 15),
    child: InkWell(
      splashColor: Colors.transparent,
      onDoubleTap: () async {
        String? strDesc = await DialogUtils.getDescrizione(context, 'Editore:', '', maxLines: 2);
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
              ' E D I T O R E ',
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
                String? strDesc = await DialogUtils.getDescrizione(context, 'Editore:', '', maxLines: 2);
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

Widget getEditoreField(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  if (widget.libroViewModel.editore.isNotEmpty && widget.libroViewModel.editore != Constant.editoreDaDefinire) {
    return _getEditoreEsistente(context, widget, fn);
  } 
  
  return _getEditoreDaDefinire(context, widget, fn);
}
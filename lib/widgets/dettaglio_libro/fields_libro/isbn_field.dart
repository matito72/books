import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:flutter/material.dart';


Widget _getIsbnEsistente(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
   return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      String? strNr = await DialogUtils.getDescrizione(context, 'ISBN', widget.libroViewModel.isbn.toString(), maxLines: 1);
      if (strNr != null) {
        fn(strNr);
      }
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.libroViewModel.isbn.toString(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        Text(
            'ISBN',
            style: TextStyle(
              fontSize: 14,
              color: Colors.lightBlue.shade100,
              fontWeight: FontWeight.bold
            ),
          ),
      ],
    ),
  );
}

Widget _getIsbnDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      String? strNr = await DialogUtils.getDescrizione(context, 'ISBN', '', maxLines: 1);
      if (strNr != null) {
        fn(strNr);
      }
    },
    child: Stack(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width * 25 / 100),
          // height: (MediaQuery.of(context).size.height * 4 / 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(color: Theme.of(context).colorScheme.background)
            // border: Border.all(color: Theme.of(context).colorScheme.inversePrimary)
            border: Border.all(color: Colors.red[300]!)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Text(
                ' ISBN',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.lightBlue.shade100,
                  fontWeight: FontWeight.bold
                ), 
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: (MediaQuery.of(context).size.width * 25 / 100),
            child: IconButton(
              iconSize: 15,
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.edit,
                color: Colors.yellowAccent
              ),
              alignment: Alignment.topRight,
              onPressed: () async {
                String? strNr = await DialogUtils.getDescrizione(context, 'ISBN', '', maxLines: 1);
                if (strNr != null) {
                  fn(strNr);
                }
              },
            ),
          ),
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width * 25 / 100),
          child: Align(
            alignment: Alignment.topCenter,
            child: IconButton(
              iconSize: 15,
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.help_outline_sharp,
                color: Colors.greenAccent
              ),
              alignment: Alignment.topCenter,
              onPressed: () async {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Importante:'),
                    content: const Text('Il campo ISBN deve essere univoco'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    ),
  );
}

Widget getIsbnField(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  // if (widget.libroViewModel.isbn.isNotEmpty && !widget.libroViewModel.isbn.startsWith("GEN")) {
  //   return _getIsbnEsistente(context, widget, fn);
  // } 
  
  return _getIsbnDaDefinire(context, widget, fn);
}
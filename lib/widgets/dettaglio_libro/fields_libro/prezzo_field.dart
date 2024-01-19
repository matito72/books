import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:flutter/material.dart';


Widget _getPrezzoEsistente(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
   return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      String? strNr = await DialogUtils.getNumero(context, 'Inserisci il prezzo', widget.libroViewModel.prezzo.toString(), false);
      if (strNr != null) {
        fn(strNr);
      }
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.libroViewModel.prezzo.toString(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        Text(
          'Prezzo',
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

Widget _getPrezzoDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      String? strNr = await DialogUtils.getNumero(context, 'Inserisci il prezzo', widget.libroViewModel.prezzo.toString(), false);
      if (strNr != null) {
        fn(strNr);
      }
    },
    child: Stack(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width * 15 / 100),
          // height: (MediaQuery.of(context).size.height * 4 / 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(color: Theme.of(context).colorScheme.background)
            border: Border.all(color: Theme.of(context).colorScheme.inversePrimary)
            // border: Border.all(color: Colors.transparent)
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
                ' Prezzo',
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
            width: (MediaQuery.of(context).size.width * 15 / 100),
            child: IconButton(
              iconSize: 15,
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.edit,
                color: Colors.yellowAccent
              ),
              alignment: Alignment.topRight,
              onPressed: () async {
                String? strNr = await DialogUtils.getNumero(context, 'Inserisci il prezzo', '', false);
                if (strNr != null) {
                  fn(strNr);
                }
              },
            ),
          ),
        )
      ],
    ),
  );
}

Widget getPrezzoField(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  if (widget.libroViewModel.prezzo.isNotEmpty) {
    return _getPrezzoEsistente(context, widget, fn);
  } 
  
  return _getPrezzoDaDefinire(context, widget, fn);
}
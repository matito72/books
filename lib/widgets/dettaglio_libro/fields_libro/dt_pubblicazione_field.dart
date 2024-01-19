import 'package:books/utilities/libro_utils.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:flutter/material.dart';


Widget _getDtPubblicazioneEsistente(BuildContext context, DettaglioLibroWidget widget, Function() fn) {
   return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      fn();
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          LibroUtils.getDataFormattata(widget.libroViewModel.dataPubblicazione),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        Text(
          'Data',
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

Widget _getDtPubblicazioneDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function() fn) {
  return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      fn();
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
                ' Data',
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
                fn();
              },
            ),
          ),
        )
      ],
    ),
  );
}

Widget getDtPubblicazioneField(BuildContext context, DettaglioLibroWidget widget, Function() fn) {
  if (widget.libroViewModel.dataPubblicazione.isNotEmpty) {
    return _getDtPubblicazioneEsistente(context, widget, fn);
  } 
  
  return _getDtPubblicazioneDaDefinire(context, widget, fn);
}
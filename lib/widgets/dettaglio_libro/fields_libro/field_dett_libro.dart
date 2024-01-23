

import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/resources/libro_field_selected.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/utilities/ordinamento_libri_utils.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class FieldDettLibro {
  BuildContext context;
  LibroViewModel libroViewModel;

  FieldDettLibro(this.context, this.libroViewModel);

  Widget getField(Color? color, String label, int maxLines, bool isHorizontal, {Function(String)? fnString, Function()? fn}) {
    dynamic fieldValue = OrdinamentoLibriUtils.getLibroViewModelValueByLabel(libroViewModel, label);
    bool fieldNonValorizzato = true;
    
    if (label == LibroFieldSelected.titolo().label) {
      fieldNonValorizzato = fieldValue.isEmpty;
    } else if (label == LibroFieldSelected.autore().label) {
      fieldNonValorizzato = fieldValue.isEmpty;
    } else if (label == LibroFieldSelected.editore().label) {
      fieldNonValorizzato = fieldValue.isEmpty || (fieldValue == Constant.editoreDaDefinire);
    } else if (label == LibroFieldSelected.dtPubblicazione().label) {
      fieldNonValorizzato = fieldValue.isEmpty;
    } else if (label == LibroFieldSelected.prezzo().label) {
      fieldNonValorizzato = fieldValue <= 0;
    } else if (label == LibroFieldSelected.isbn().label) {
      fieldNonValorizzato = libroViewModel.isbn.isEmpty || libroViewModel.isbn.startsWith("GEN");
    } else if (label == LibroFieldSelected.nrPagine().label) {
      fieldNonValorizzato = fieldValue <= 0;
    } else if (label == LibroFieldSelected.dtPubblicazione().label) {
      fieldNonValorizzato = fieldValue.isEmpty;
    }

    if (fieldNonValorizzato) {
      if (isHorizontal) {
        return _getValueFieldWidgetDaDefinire(color, label, fieldValue, maxLines, fnString, fn);
      } else {
        return _getInkWellDaDefinire(color, label, fieldValue, maxLines, fnString, fn);
      }
    }

    if (isHorizontal) {
      return _getValueFieldWidgetEsistente(color, label, fieldValue, maxLines, fnString, fn);
    } else {
      return _geInkWellWidgetEsistente(color, label, fieldValue, maxLines, fnString, fn);
    }
  }

  _execFnString(String label, dynamic fieldValue, int maxLines, Function(String)? fnString, Function()? fn) async {
    String? strDesc = "";

    if (label == LibroFieldSelected.nrPagine().label) {
      strDesc = await DialogUtils.getNumero(context, '$label:', fieldValue.toString(), true);
    } else if (label == LibroFieldSelected.prezzo().label) {
      strDesc = await DialogUtils.getNumero(context, '$label:', fieldValue.toString(), false);
    } else if (label == LibroFieldSelected.dtPubblicazione().label) {
      if (fn != null) {
        fn();
      }
    } else {
      strDesc = await DialogUtils.getDescrizione(context, '$label:', fieldValue.toString(), maxLines: maxLines);
    }

    if ((fnString != null) && (strDesc != null)) {
      fnString(strDesc);
    }
  }

  Widget _getValueFieldWidgetEsistente(Color? color, String label, dynamic fieldValue, int maxLines, Function(String)? fnString, Function()? fn) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15),
      child: InkWell(
        splashColor: Colors.transparent,
        onDoubleTap: () => _execFnString(label, fieldValue, maxLines, fnString, fn),
        child: ExpandableText(
          (label == LibroFieldSelected.autore().label)
            ? libroViewModel.lstAutori.join(', ')
            : fieldValue.toString(),
          maxLines: maxLines,
          style: TextStyle(
            fontSize: (label == LibroFieldSelected.titolo().label) 
              ? 18
              : (label == LibroFieldSelected.autore().label) ? 16 : 14,
            color: color,
          ),
          expandText: '',
          collapseText: '<<',
        ),
        // child: ReadMoreText.selectable(
        //   fieldValue,
        //   numLines: 1,
        //   style: const TextStyle(
        //     fontSize: 14,
        //     color: Colors.white,
        //   ),
        //   readMoreTextStyle: TextStyle(color: Colors.amber.shade200),
        //   readMoreText: '', 
        //   readLessText: '', 
        // ),
      )
    );
  }

  Widget _geInkWellWidgetEsistente(Color? color, String label, dynamic fieldValue, int maxLines, Function(String)? fnString, Function()? fn) {
    return InkWell(
      splashColor: Colors.transparent,
      onDoubleTap: () => _execFnString(label, fieldValue, maxLines, fnString, fn),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            (label == LibroFieldSelected.dtPubblicazione().label)
             ? LibroUtils.getDataFormattata(libroViewModel.dataPubblicazione)
             : fieldValue.toString(),
            style: TextStyle(
              fontSize: 14,
              color: color,
            ),
          ),
          Text(
              (label == LibroFieldSelected.dtPubblicazione().label)
                ? 'Data'
                : label,
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
  
  Widget _getValueFieldWidgetDaDefinire(Color? color, String label, dynamic fieldValue, int maxLines, Function(String)? fnString, Function()? fn) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15),
      child: InkWell(
        splashColor: Colors.transparent,
        onDoubleTap: () => _execFnString(label, '', maxLines, fnString, fn),
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
                _getLabelSpaziata(label),
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
                    onPressed: () => _execFnString(label, '', maxLines, fnString, fn),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _getInkWellDaDefinire(Color? color, String label, dynamic fieldValue, int maxLines, Function(String)? fnString, Function()? fn) {
    return InkWell(
      splashColor: Colors.transparent,
      onDoubleTap: () => _execFnString(label, '', maxLines, fnString, fn),
      child: Stack(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width * 20 / 100),
            // height: (MediaQuery.of(context).size.height * 4 / 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              // border: Border.all(color: Theme.of(context).colorScheme.background)
              // border: Border.all(color: Theme.of(context).colorScheme.inversePrimary)
              border: (label == LibroFieldSelected.isbn().label)
                ? Border.all(color: Colors.red[300]!)
                : Border.all(color: Theme.of(context).colorScheme.inversePrimary)
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
                  (label == LibroFieldSelected.dtPubblicazione().label)
                    ? ' Data'
                    : ' $label',
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
              width: (MediaQuery.of(context).size.width * 20 / 100),
              child: IconButton(
                iconSize: 15,
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.yellowAccent
                ),
                alignment: Alignment.topRight,
                onPressed: () => _execFnString(label, '', maxLines, fnString, fn),
              ),
            ),
          ),
          (label == LibroFieldSelected.isbn().label) 
          ? SizedBox(
            width: (MediaQuery.of(context).size.width * 25 / 100),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                iconSize: 15,
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.help_outline_sharp,
                  color: Colors.greenAccent
                ),
                alignment: Alignment.topLeft,
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
          : const Text('')
        ],
      ),
    );
  }

  String _getLabelSpaziata(String label) {
    List<String> ls = [];
    for(int i=0; i<label.length; i++) {
      ls.add(' ');
      ls.add(label.substring(i, i+1).toUpperCase());
    }
    return ' ${ls.join()}';
  }
}
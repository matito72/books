import 'package:flutter/material.dart';
import 'package:books/models/widget_desc.module.dart';

class FormLibreriaNew {

  final WidgetDescModel _nomeLibreriaWid;
  final WidgetDescModel _siglaLibreriaWid;

  FormLibreriaNew(this._nomeLibreriaWid, this._siglaLibreriaWid); 


  Future<String?>  getMultiDescrizione(BuildContext context) {
    // TextEditingController ctrlNome = TextEditingController();
    // TextEditingController ctrlSigla = TextEditingController();

    List<Widget> lstWidget = List.empty(growable: true);

    TextField txtSigla = TextField(
      textCapitalization: TextCapitalization.characters,
      maxLines: _siglaLibreriaWid.maxLines,
      maxLength: 3,
      autofocus: true,
      readOnly: _siglaLibreriaWid.readOnly,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: _siglaLibreriaWid.strHintText,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        // fillColor: Colors.brown[200],
        // filled: widgetDescModel.readOnly
      ),
      style: TextStyle(
        color: _siglaLibreriaWid.readOnly 
          ? Theme.of(context).primaryColor.withOpacity(0.4) 
          : Theme.of(context).primaryColor,
        fontStyle: _siglaLibreriaWid.readOnly ? FontStyle.italic : FontStyle.normal
      ),
      controller: _siglaLibreriaWid.textController
    );

    TextField txtDescrizione = TextField(
      textCapitalization: TextCapitalization.words,
      maxLines: _nomeLibreriaWid.maxLines,
      autofocus: true,
      readOnly: _nomeLibreriaWid.readOnly,
      keyboardType: TextInputType.multiline,
      onChanged: (value) => { _siglaLibreriaWid.textController.text = value.toLowerCase().replaceAll(RegExp('[aeiou]'),'').toUpperCase() },
      decoration: InputDecoration(
        hintText: _nomeLibreriaWid.strHintText,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        // fillColor: Colors.brown[200],
        // filled: widgetDescModel.readOnly
      ),
      style: TextStyle(
        color: _nomeLibreriaWid.readOnly 
          ? Theme.of(context).primaryColor.withOpacity(0.4) 
          : Theme.of(context).primaryColor,
        fontStyle: _nomeLibreriaWid.readOnly ? FontStyle.italic : FontStyle.normal
      ),
      controller: _nomeLibreriaWid.textController
    );

    lstWidget.add(txtDescrizione);
    lstWidget.add(const Padding(padding: EdgeInsets.only(top: 30)));   
    lstWidget.add(txtSigla);

    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          //   fontStyle: FontStyle.italic,
          //   color: Colors.black,
          //   backgroundColor: Colors.blueAccent,
          // ),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
          shadowColor: Colors.blueAccent,
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:  Column(
              children: lstWidget,
            )
          ),
          clipBehavior: Clip.hardEdge,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')
            ),
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop('${_nomeLibreriaWid.textController.text};${_siglaLibreriaWid.textController.text}')
              },
              child: const Text('OK')
            ),
          ],
        );
      },
    );
  }


}

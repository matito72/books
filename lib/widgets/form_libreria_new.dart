import 'package:flutter/material.dart';
import 'package:books/models/widget_desc.module.dart';

class FormLibreriaNew {

  WidgetDescModel nomeLibreriaWid;
  WidgetDescModel siglaLibreriaWid;

  FormLibreriaNew(this.nomeLibreriaWid, this.siglaLibreriaWid); 


  Future<String?>  getMultiDescrizione(BuildContext context) {
    // TextEditingController ctrlNome = TextEditingController();
    // TextEditingController ctrlSigla = TextEditingController();

    List<Widget> lstWidget = List.empty(growable: true);

    TextField txtSigla = TextField(
      textCapitalization: TextCapitalization.characters,
      maxLines: siglaLibreriaWid.maxLines,
      maxLength: 3,
      autofocus: true,
      readOnly: siglaLibreriaWid.readOnly,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: siglaLibreriaWid.strHintText,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        // fillColor: Colors.brown[200],
        // filled: widgetDescModel.readOnly
      ),
      style: TextStyle(
        color: siglaLibreriaWid.readOnly 
          ? Theme.of(context).primaryColor.withOpacity(0.4) 
          : Theme.of(context).primaryColor,
        fontStyle: siglaLibreriaWid.readOnly ? FontStyle.italic : FontStyle.normal
      ),
      controller: siglaLibreriaWid.textController
    );

    TextField txtDescrizione = TextField(
      textCapitalization: TextCapitalization.words,
      maxLines: nomeLibreriaWid.maxLines,
      autofocus: true,
      readOnly: nomeLibreriaWid.readOnly,
      keyboardType: TextInputType.multiline,
      onChanged: (value) => { siglaLibreriaWid.textController.text = value.toLowerCase().replaceAll(RegExp('[aeiou]'),'').toUpperCase() },
      decoration: InputDecoration(
        hintText: nomeLibreriaWid.strHintText,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        // fillColor: Colors.brown[200],
        // filled: widgetDescModel.readOnly
      ),
      style: TextStyle(
        color: nomeLibreriaWid.readOnly 
          ? Theme.of(context).primaryColor.withOpacity(0.4) 
          : Theme.of(context).primaryColor,
        fontStyle: nomeLibreriaWid.readOnly ? FontStyle.italic : FontStyle.normal
      ),
      controller: nomeLibreriaWid.textController
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
                Navigator.of(context).pop('${nomeLibreriaWid.textController.text};${siglaLibreriaWid.textController.text}')
              },
              child: const Text('OK')
            ),
          ],
        );
      },
    );
  }


}

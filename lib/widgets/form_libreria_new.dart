import 'package:flutter/material.dart';
import 'package:books/models/widget_desc.module.dart';

class FormLibreriaNew {

  final WidgetDescModel _nomeLibreriaWid;

  FormLibreriaNew(this._nomeLibreriaWid);


  Future<String?>  getMultiDescrizione(BuildContext context) {

    List<Widget> lstWidget = List.empty(growable: true);

    TextField txtDescrizione = TextField(
      textCapitalization: TextCapitalization.words,
      maxLines: _nomeLibreriaWid.maxLines,
      autofocus: true,
      readOnly: _nomeLibreriaWid.readOnly,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: _nomeLibreriaWid.strHintText,
      ),
      style: Theme.of(context).textTheme.titleSmall,
      controller: _nomeLibreriaWid.textController
    );

    lstWidget.add(txtDescrizione);
    lstWidget.add(const Padding(padding: EdgeInsets.only(top: 30)));   
    // lstWidget.add(txtSigla);

    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
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
                Navigator.of(context).pop(_nomeLibreriaWid.textController.text)
              },
              child: const Text('OK')
            ),
          ],
        );
      },
    );
  }


}

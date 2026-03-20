import 'package:book/models/widget_desc.module.dart';
import 'package:flutter/material.dart';



class FormLibreriaNew {

  final WidgetDescModel _nomeLibreriaWid;

  FormLibreriaNew(this._nomeLibreriaWid);

  Future<String?>  getMultiDescrizione(BuildContext context) {
    List<Widget> lstWidget = List.empty(growable: true);

    TextField txtDescrizione = TextField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: _nomeLibreriaWid.maxLines,
      autofocus: true,
      readOnly: _nomeLibreriaWid.readOnly,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: _nomeLibreriaWid.strHintText,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Colors.amber[200],
          fontWeight: FontWeight.bold,
        ),
      ),
      // style: Theme.of(context).textTheme.titleSmall,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Colors.limeAccent,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          if (value.length == 1 && value != value.toUpperCase()) {
            _nomeLibreriaWid.textController.value = TextEditingValue(
              text: value.toUpperCase(),
              selection: TextSelection.collapsed(offset: 1),
            );
          }
        },
      controller: _nomeLibreriaWid.textController
    );

    lstWidget.add(txtDescrizione);
    lstWidget.add(const Padding(padding: EdgeInsets.only(top: 30)));   

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
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.amber[200],
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(_nomeLibreriaWid.textController.text)
              },
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
          ],
        );
      },
    );

  }

}

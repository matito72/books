import 'package:books/models/widget_desc_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogUtils {

  static Future<String?>  getMultiDescrizione(BuildContext context, List<WidgetDescModel> lstWidgetDescModel) {
    List<Widget> lstWidget = List.empty(growable: true);
    for (var widgetDescModel in lstWidgetDescModel) {
      lstWidget.add(TextField(
        textCapitalization: TextCapitalization.words,
        maxLines: widgetDescModel.maxLines,
        autofocus: true,
        readOnly: widgetDescModel.readOnly,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: widgetDescModel.strHintText,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // fillColor: Colors.brown[200],
          // filled: widgetDescModel.readOnly
        ),
        style: TextStyle(
          color: widgetDescModel.readOnly 
            ? Theme.of(context).primaryColor.withOpacity(0.4) 
            : Theme.of(context).primaryColor,
          fontStyle: widgetDescModel.readOnly ? FontStyle.italic : FontStyle.normal
        ),
        controller: widgetDescModel.textController
      ));
      lstWidget.add(const Padding(padding: EdgeInsets.only(top: 30)));
    }    

    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            backgroundColor: Colors.blueAccent,
          ),
          shadowColor: Colors.blueAccent,
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:  Column(
              children: lstWidget,
            )
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')
            ),
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(lstWidgetDescModel.map((w) => w.textController.text).join('; '))
              },
              child: const Text('OK')
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> showConfirmationSiNo(BuildContext parentContext, String strQuestion) async {
    return showDialog<bool>(
      context: parentContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(strQuestion),
          actions: <Widget>[
            TextButton(
              child: const Text('Si'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<String?> getDescrizione(BuildContext context, String strHintText, String preValue, {int maxLines = 15}) {
    TextEditingController textController = TextEditingController();
    textController.text = preValue;

    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            backgroundColor: Colors.blueAccent,
          ),
          shadowColor: Colors.blueAccent,
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: TextField(
              maxLines: maxLines,
              autofocus: true,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: strHintText),
              controller: textController,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')
            ),
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(textController.text)
              },
              child: const Text('OK')
            ),
          ],
        );
      },
    );
  }

  static Future<String?> getNumero(BuildContext context, String strHintText, String preValue, bool isDigitOnly) {
    TextEditingController textController = TextEditingController();
    textController.text = (preValue == "0") ? '' : preValue;

    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            backgroundColor: Colors.blueAccent,
          ),
          shadowColor: Colors.blueAccent,
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: strHintText),
            inputFormatters: isDigitOnly 
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
            controller: textController,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')
            ),
            TextButton(
              onPressed: () => {
                // setState(() {
                //   int? nr = int.tryParse(textController.text);
                //   libroViewModel.nrPagine = (nr != null) ? nr : 0;
                // }),
                Navigator.of(context).pop(textController.text)
              },
              child: const Text('OK')
            ),
          ],
        );
      },
    );
  }
}
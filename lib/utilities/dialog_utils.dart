import 'package:books/models/widget_desc.module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
        // style: TextStyle(
        //   color: widgetDescModel.readOnly 
        //     ? Theme.of(context).primaryColor.withOpacity(0.4) 
        //     : Theme.of(context).primaryColor,
        //   fontStyle: widgetDescModel.readOnly ? FontStyle.italic : FontStyle.normal
        // ),
        style: Theme.of(context).textTheme.titleSmall,
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

  static Future<String?> getAnno(BuildContext context, String dataPubblicazione) {
    DateTime selectedDate = DateTime.now();
    if (dataPubblicazione.length == 4) {
      selectedDate = DateFormat("yyyy").parse(dataPubblicazione);
    }
    
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Anno di pubblicazione:"),
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.blue.shade200
          ),
          contentTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontStyle: FontStyle.italic,
            backgroundColor: Colors.blueAccent,
          ),
          shadowColor: Colors.blueAccent,
          content: SizedBox( 
            width: 300,
            height: 250,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              // initialDate: DateTime.now(),
              selectedDate: selectedDate,
              onChanged: (DateTime dateTime) {
                Navigator.of(context).pop(dateTime.year.toString());
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')
            ),
          ],
        );
      }
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
              style: Theme.of(context).textTheme.titleSmall
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
            decoration: InputDecoration(hintText: strHintText),
            keyboardType: TextInputType.number,
            inputFormatters: isDigitOnly 
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
            controller: textController,
            style: Theme.of(context).textTheme.titleSmall
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
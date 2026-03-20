import 'package:book/models/widget_desc.module.dart';
import 'package:book/utilities/upper_case_words_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DialogUtils {
  static Future<String?> getMultiDescrizione(
    BuildContext context,
    List<WidgetDescModel> lstWidgetDescModel,
  ) {
    List<Widget> lstWidget = List.empty(growable: true);
    for (var widgetDescModel in lstWidgetDescModel) {
      lstWidget.add(
        TextField(
          textCapitalization: TextCapitalization.words,
          maxLines: widgetDescModel.maxLines,
          autofocus: true,
          readOnly: widgetDescModel.readOnly,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: widgetDescModel.strHintText,
            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.amber[200],
              // fontWeight: FontWeight.bold,
            ),
          ),
          style: widgetDescModel.readOnly
              ? TextStyle(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                  fontStyle: FontStyle.italic,
                )
              : Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.limeAccent,
            fontWeight: FontWeight.bold,
          ),
          // ),
          // style: Theme.of(context).textTheme.titleSmall,
          controller: widgetDescModel.textController,
        ),
      );
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
            child: Column(children: lstWidget),
          ),
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
                Navigator.of(context).pop(lstWidgetDescModel.map((w) => w.textController.text).join('; '),),
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

  static Future<bool?> showConfirmationSiNo(
    BuildContext parentContext,
    String strQuestion,
  ) async {
    return showDialog<bool>(
      context: parentContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            strQuestion,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.limeAccent,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.amber[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<String?> getAnno(
    BuildContext context,
    String dataPubblicazione,
  ) {
    DateTime selectedDate = DateTime.now();
    if (dataPubblicazione.length == 4) {
      selectedDate = DateFormat("yyyy").parse(dataPubblicazione);
    }

    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Anno di pubblicazione:",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.amber[200],
              fontWeight: FontWeight.bold,
            )
          ),
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.blue.shade200,
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
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.amber[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<String?> getDescrizione(
    BuildContext context,
    String strHintText,
    String preValue, {
      int maxLines = 15,
      bool isCapitalize = false}
  ) {
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
              decoration: InputDecoration(
                  hintText: strHintText,
                hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.amber[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
              controller: textController,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.limeAccent,
                fontWeight: FontWeight.bold,
              ),
              textCapitalization: TextCapitalization.words,
              inputFormatters: [
                UpperCaseWordsFormatter(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.amber[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {Navigator.of(context).pop(textController.text)},
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<String?> getNumero(
    BuildContext context,
    String strHintText,
    String preValue,
    bool isDigitOnly,
  ) {
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
            decoration: InputDecoration(
              hintText: strHintText,
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.amber[200],
                fontWeight: FontWeight.bold,
              )
            ),
            keyboardType: TextInputType.number,
            inputFormatters: isDigitOnly
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
            controller: textController,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.limeAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.amber[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                // setState(() {
                //   int? nr = int.tryParse(textController.text);
                //   libroViewModel.nrPagine = (nr != null) ? nr : 0;
                // }),
                Navigator.of(context).pop(textController.text),
              },
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

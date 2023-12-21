import 'package:flutter/material.dart';

class WidgetDescModel {
  String strHintText;
  String preValue;
  int maxLines;
  bool readOnly;
  late TextEditingController textController;

  WidgetDescModel(this.strHintText, this.preValue, {this.maxLines = 15, this.readOnly = false}) {
    textController = TextEditingController();
    textController.text = preValue;
  }
}
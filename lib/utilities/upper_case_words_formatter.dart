import 'package:flutter/services.dart';

class UpperCaseWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.text.isEmpty) return newValue;

    // Converte la prima lettera di ogni parola in maiuscolo
    String text = newValue.text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');

    return newValue.copyWith(
      text: text,
      selection: newValue.selection, // Mantiene il cursore nella posizione corretta
    );
  }
}
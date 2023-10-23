import 'package:flutter/material.dart';

class BookStyle {
  static final bookStyleTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.yellow.shade400,
    // fontFamily: 'Georgia',
    fontFamily: 'Muli',
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
      titleMedium: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal),
      titleSmall: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    // dialogBackgroundColor: Colors.red,
    scaffoldBackgroundColor: Colors.white12,
    colorScheme: ColorScheme(
      background: Colors.orange.shade400,
      error: Colors.red.shade500,
      onBackground: Colors.yellow.shade200,
      onError: Colors.red.shade300,
      onPrimary: Colors.black,
      onSecondary: Colors.yellow.shade50,
      onSurface: Colors.yellow.shade500,
      primary: Colors.yellow.shade100,
      secondary: Colors.lightBlue.shade200,
      surface: const Color.fromARGB(255, 45, 122, 158),
      brightness: Brightness.dark,
    ),
  );
}

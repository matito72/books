import 'package:flutter/material.dart';

class BookStyle {
  static final bookStyleTheme = ThemeData(
    brightness: Brightness.dark,
    // primaryColor: Colors.yellow.shade400,
    primaryColor: Colors.blueGrey,
    // fontFamily: 'Georgia',
    fontFamily: 'Muli',
    textTheme: TextTheme(
      headlineSmall: const TextStyle(
        fontSize: 14.0, 
        fontStyle: FontStyle.normal, 
        color: Colors.white,
        letterSpacing: 1.4
      ),
      titleLarge: const TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
      titleMedium: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal),
      titleSmall: TextStyle(
        fontSize: 14.0, 
        fontStyle: FontStyle.normal,
        color: Colors.yellow.shade50
      ),
      labelSmall: TextStyle(
        fontSize: 12.0, 
        fontStyle: FontStyle.normal,
        color: Colors.yellow.shade50
      ),
      bodyMedium: const TextStyle(fontSize: 14.0, fontFamily: 'Hind')      
    ),
    // dialogBackgroundColor: Colors.red,
    scaffoldBackgroundColor:  Colors.blueGrey[900]!, // const Color.fromARGB(255, 75, 64, 64),
    colorScheme: ColorScheme(
      background: Colors.blueGrey[900]!,
      error: Colors.redAccent[100]!,
      onBackground: Colors.yellow.shade200,
      onError: Colors.red.shade300,
      onPrimary: Colors.blueGrey[700]!,
      onSecondary: Colors.yellow.shade50,
      onSurface: Colors.blueGrey[200]!, //Colors.yellow.shade500,
      primary: Colors.yellow.shade100,
      secondary: Colors.lightBlue.shade200,
      tertiary: const Color.fromARGB(255, 211, 212, 201),
      surface: const Color.fromARGB(255, 45, 122, 158),
      brightness: Brightness.dark,
    ),
    // cardColor: const Color.fromARGB(255, 13, 50, 68),
    cardColor: const Color.fromARGB(255, 13, 50, 68),
  );
}

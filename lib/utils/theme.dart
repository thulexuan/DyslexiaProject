import 'package:dyslexia_project/utils/color.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    // appBarTheme: AppBarTheme(
    //   backgroundColor: primaryColor[50],
    //   foregroundColor: Colors.black
    // )
    textTheme: TextTheme(
      // for normal text
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
      )
    ),
      sliderTheme: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
      )
  );

  static ThemeData customThemeData(double width, double height) {
    return ThemeData(
      // Define the text theme
      textTheme: TextTheme(
        // for text of TextButton
          bodySmall: TextStyle(
            fontSize: width / 20,
            color: Colors.blue,
            fontWeight: FontWeight.bold
          ),
        // for normal text, without fontWeight = bold
          bodyMedium: TextStyle(
            fontSize: width / 20,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: width / 20,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        // for headline
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: width / 12
          ),
        // for text inside elevatedButton
          labelSmall: TextStyle(
            fontSize: width / 20,
            color: Colors.white,
          )
      ),
      // button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            shape:
            MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.blue)
                )
            )
        )

      )
    );
  }
}


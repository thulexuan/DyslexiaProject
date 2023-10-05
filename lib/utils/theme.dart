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
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
      )
    ),
      sliderTheme: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
      )
  );

}
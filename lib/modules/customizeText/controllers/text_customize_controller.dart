import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextCustomizeController extends GetxController {

  var currentFontSize = 10.0.obs;
  var currentTextColor = "black".obs;
  var currentBackgroundColor = "yellow".obs;
  var currentFontStyle = "";
  var currentCharacterSpacing = 1.0.obs;
  var currentWordSpacing = 1.0.obs;

  List<Color> backgroundColor = [
    Colors.white,
    Colors.yellowAccent,
    Colors.pink,
    Colors.blue
  ];


}
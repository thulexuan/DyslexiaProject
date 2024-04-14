

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestController extends GetxController {

  final textCustomizeController = Get.put(TextCustomizeController());

  var arialFontFrequency = 0.obs;
  var timesFontFrequency = 0.obs;
  var letterSpacingNormalFrequency = 0.obs;
  var letterSpacingExpandFrequency = 0.obs;
  var wordSpacingNormalFrequency = 0.obs;
  var wordSpacingExpandFrequency = 0.obs;
  var fontSizeSmall = 0.obs;
  var fontSizeBig = 0.obs;
  var opacity100 = 0.obs;
  var opacity25 = 0.obs;
  var opacity50 = 0.obs;
  var opacity75 = 0.obs;

  var pair1 = 0.obs;
  var pair2 = 0.obs;
  var pair3 = 0.obs;
  var pair4 = 0.obs;

  var answers = List.generate(24, (index) => -1);

  Future<void> process() async {

    List<String> errorWords = [];
    List<String> type_1 = ['d', 'b', 'p', 'q'];
    List<String> type_2 = ['m', 'n', 'u'];

    for (int i=0;i<24;i++) {
      // test letter
      if (0 <= i && i <= 2) {
        switch (answers[i]) {
          case 0:
            fontSizeSmall++;
            arialFontFrequency++;
            break;
          case 1:
            fontSizeBig++;
            arialFontFrequency++;
            break;
          case 2:
            fontSizeSmall++;
            timesFontFrequency++;
            break;
          case 3:
            fontSizeBig++;
            timesFontFrequency++;
            break;
        }
      }
      // test one-word
      if (3 <= i && i <= 5) {
        switch (answers[i]) {
          case 0:
            fontSizeSmall++;
            arialFontFrequency++;
            letterSpacingNormalFrequency++;
            break;
          case 1:
            fontSizeBig++;
            arialFontFrequency++;
            letterSpacingNormalFrequency++;
            break;
          case 2:
            fontSizeBig++;
            arialFontFrequency++;
            letterSpacingExpandFrequency++;
            break;
          case 3:
            fontSizeSmall++;
            timesFontFrequency++;
            letterSpacingNormalFrequency++;
            break;
          case 4:
            fontSizeBig++;
            timesFontFrequency++;
            letterSpacingNormalFrequency++;
            break;
          case 5:
            fontSizeBig++;
            timesFontFrequency++;
            letterSpacingExpandFrequency++;
            break;
        }
      }

      // test 2-word
      if (6 <=i && i <= 8) {
        switch (answers[i]) {
          case 0:
            fontSizeSmall++;
            arialFontFrequency++;
            wordSpacingNormalFrequency++;
            break;
          case 1:
            fontSizeBig++;
            arialFontFrequency++;
            wordSpacingNormalFrequency++;
            break;
          case 2:
            fontSizeBig++;
            arialFontFrequency++;
            wordSpacingExpandFrequency++;
            break;
          case 3:
            fontSizeSmall++;
            timesFontFrequency++;
            wordSpacingNormalFrequency++;
            break;
          case 4:
            fontSizeBig++;
            timesFontFrequency++;
            wordSpacingNormalFrequency++;
            break;
          case 5:
            fontSizeBig++;
            timesFontFrequency++;
            wordSpacingExpandFrequency++;
            break;
        }
      }

      // test with sentence
      if (i == 9 || i == 10) {
        switch (answers[i]) {
          case 0:
            arialFontFrequency++;
            break;
          case 1:
            timesFontFrequency++;
            break;
        }
      }

      // test mirror letter

      if (i >= 11 && i <= 13) {
        
        switch (answers[i]) {
          case 1:
            arialFontFrequency++;
            fontSizeSmall++;
            break;
          case 4:
            timesFontFrequency++;
            fontSizeSmall++;
            break;
          case 7:
            arialFontFrequency++;
            fontSizeBig++;
            break;
          case 10:
            timesFontFrequency++;
            fontSizeBig++;
            break;
          default: 
            if (i==11 || i==12) {
              bool isExist = type_1.every((element) => errorWords.contains(element));
              if (!isExist) {
                errorWords.addAll(type_1);
              }
            }
            if (i == 13) {
              errorWords.addAll(type_2);
            }
        }
        
      }

      // test contrast

      if (i >= 14 && i <= 18) {

        switch (answers[i]) {
          case 0:
            opacity100++;
            break;
          case 1:
            opacity25++;
            break;
          case 2:
            opacity50++;
            break;
          case 3:
            opacity75++;
            break;
        }

      }

      // test background-text pair

      if (i >= 19 && i <= 23) {

        switch (answers[i]) {
          case 0:
            pair1++;
            break;
          case 1:
            pair2++;
            break;
          case 2:
            pair3++;
            break;
          case 3:
            pair4++;
            break;
        }

      }
    }
    // save to database

    // save font size
    if (fontSizeBig.value > fontSizeSmall.value) {
      textCustomizeController.saveToDb('fontSize', 36);
    } else {
      textCustomizeController.saveToDb('fontSize', 24);
    }

    // save font family
    if (arialFontFrequency.value > timesFontFrequency.value) {
      textCustomizeController.saveToDb('fontFamily', 'Arial');
    } else {
      textCustomizeController.saveToDb('fontFamily', 'Times New Roman');
    }
    // save letter spacing
    if (letterSpacingExpandFrequency.value > letterSpacingNormalFrequency.value) {
      textCustomizeController.saveToDb('letterSpacing', 5);
    } else {
      textCustomizeController.saveToDb('letterSpacing', 0);
    }
    // save word spacing
    if (wordSpacingExpandFrequency.value > wordSpacingNormalFrequency.value) {
      textCustomizeController.saveToDb('wordSpacing', 21);
    } else {
      textCustomizeController.saveToDb('wordSpacing', 0);
    }

    // save errorWords in mirror letter test

    if (errorWords.isNotEmpty) {
      textCustomizeController.saveToDb('errorWords', errorWords);
    }

    // save opacity
    int maxFrequencyOfOpacity = max(max(max(opacity100.value, opacity75.value), opacity50.value), opacity25.value);
    if (maxFrequencyOfOpacity == opacity100.value) {
      textCustomizeController.saveToDb('opacity', 1.0);
    } else if (maxFrequencyOfOpacity == opacity75.value) {
      textCustomizeController.saveToDb('opacity', 0.75);
    } else if (maxFrequencyOfOpacity == opacity50.value) {
      textCustomizeController.saveToDb('opacity', 0.5);
    } else if (maxFrequencyOfOpacity == opacity25.value) {
      textCustomizeController.saveToDb('opacity', 0.25);
    }

    // save background and text color

    int maxPairFrequency = max(max(max(pair1.value, pair2.value), pair3.value), pair4.value);
    if (maxPairFrequency == pair1.value) {
      textCustomizeController.saveToDb('textColor', 'off-black');
      textCustomizeController.saveToDb('backgroundColor', 'off-white');
    } else if (maxPairFrequency == pair2.value) {
      textCustomizeController.saveToDb('textColor', 'black');
      textCustomizeController.saveToDb('backgroundColor', 'white');
    } else if (maxPairFrequency == pair3.value) {
      textCustomizeController.saveToDb('textColor', 'black');
      textCustomizeController.saveToDb('backgroundColor', 'creme');
    } else if (maxPairFrequency == pair4.value) {
      textCustomizeController.saveToDb('textColor', 'blue');
      textCustomizeController.saveToDb('backgroundColor', 'yellow');
    }

  }


}


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

  var answers = List.generate(14, (index) => -1);

  Future<void> process() async {

    List<String> errorWords = [];
    List<String> type_1 = ['d', 'b', 'p', 'q'];
    List<String> type_2 = ['m', 'n', 'u'];

    for (int i=0;i<14;i++) {
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

  }


}
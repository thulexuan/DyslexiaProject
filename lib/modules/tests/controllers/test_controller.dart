

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
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

  var answers = List.generate(9, (index) => -1);

  process() async {
    for (int i=0;i<3;i++) {
      if (0 <= i && i <= 2) {
        if (answers[i] == 0) {
          arialFontFrequency++;
          fontSizeSmall++;
        }
        if (answers[i] == 1) {
          arialFontFrequency++;
          fontSizeBig++;
        }
        if (answers[i] == 2) {
          timesFontFrequency++;
          fontSizeSmall++;
        }
        if (answers[i] == 3) {
          timesFontFrequency++;
          fontSizeBig++;
        }
      }
    }
    // save to database
    if (fontSizeBig.value > fontSizeSmall.value) {
      textCustomizeController.saveToDb('fontSize', 36);
    }
  }

}
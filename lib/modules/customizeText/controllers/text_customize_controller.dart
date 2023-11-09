import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/data/color_mapping.dart';
import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextCustomizeController extends GetxController {

  var currentFontSize = 10.0.obs;
  var currentTextColor = "black".obs;
  var currentBackgroundColor = "white".obs;
  var currentFontStyle = "".obs;
  var currentCharacterSpacing = 1.0.obs;
  var currentWordSpacing = 1.0.obs;
  var currentLineSpacing = 1.0.obs;

  var fontFamilySelectedIndex = 0.obs;
  var backgroundColorSelectedIndex = 0.obs;
  var textColorSelectedIndex = 0.obs;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',
        isEqualTo: prefs.getString('email')) // add your condition here
        .get();

    // get data from the first document in the snapshot
    final Object? data =
    snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    var fontSize = data != null && data is Map<String, dynamic>
        ? data['fontSize']
        : -1.0;
    currentFontStyle.value = data != null && data is Map<String, dynamic>
        ? data['fontFamily']
        : 'Arial' ;
    currentBackgroundColor.value = data != null && data is Map<String, dynamic>
        ? data['backgroundColor']
        : 'white';
    currentTextColor.value = data != null && data is Map<String, dynamic>
        ? data['textColor']
        : 'black' ;
    var letterSpacing = data != null && data is Map<String, dynamic>
        ? data['letterSpacing']
        : 0.0;
    var wordSpacing = data != null && data is Map<String, dynamic>
        ? data['wordSpacing']
        : 0.0 ;
    var lineSpacing = data != null && data is Map<String, dynamic>
        ? data['lineSpacing']
        : 0.0 ;

    currentFontSize.value = fontSize.toDouble();
    currentCharacterSpacing.value = letterSpacing.toDouble();
    currentWordSpacing.value = wordSpacing.toDouble();
    currentLineSpacing.value = lineSpacing.toDouble();

    fontFamilySelectedIndex.value = fontFamilyList.indexOf(currentFontStyle.value);
    backgroundColorSelectedIndex.value = backgroundColor_text.indexOf(currentBackgroundColor.value);
    textColorSelectedIndex.value = textColor_text.indexOf(currentTextColor.value);
  }

  // save value to database when have change from user
  Future<void> saveToDb(String fieldName, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',
        isEqualTo: prefs.getString('email')) // add your condition here
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs[0]
        .reference
        .update({
        fieldName : value
      });
    }


  }

  List<String> fontFamilyList = [
    'Arial',
    'Times New Roman',
    'Computer Modern Unicode',
    'Comic Sans',
    'Courier',
    'Helvetica',
    'Verdana',
    'Open Dyslexic'
  ];

  List<Color> backgroundColor = [
    Colors.white,
    Color.fromRGBO(255, 255, 259, 1),
    Color.fromRGBO(250, 250, 200, 1),
    Color.fromRGBO(255, 255, 0, 1),
    Color.fromRGBO(237, 209, 176, 1),
    Color.fromRGBO(237, 221, 110, 1),
    Color.fromRGBO(248, 253, 137, 1),
    Color.fromRGBO(150, 173, 252, 1),
    Color.fromRGBO(219, 225, 241, 1),
    Color.fromRGBO(168, 242, 154, 1),
    Color.fromRGBO(216, 211, 214, 1),
    Color.fromRGBO(185, 135, 220, 1),
    Color.fromRGBO(224, 166, 170, 1),
    Color.fromRGBO(165, 247, 225, 1),
    Color.fromRGBO(185, 185, 0, 1),
    Color.fromRGBO(160, 160, 0, 1),
  ];

  List<String> backgroundColor_text = [
    'white',
    'off-white',
    'creme',
    'yellow',
    'peach',
    'orange',
    'yellowAccent',
    'blue',
    'blue grey',
    'green',
    'grey',
    'purple',
    'red',
    'turquoise',
    'light mucky green',
    'mucky green',
  ];

  List<Color> textColor = [
    Colors.black,
    Color.fromRGBO(10, 10, 10, 1),
    Color.fromRGBO(0, 0, 125, 1),
    Color.fromRGBO(30, 30, 0, 1),
    Color.fromRGBO(40, 40, 0, 1),
  ];

  List<String> textColor_text = [
    'black',
    'off-black',
    'blue',
    'dark brown',
    'brown'
  ];

}
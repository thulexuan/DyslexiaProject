import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextCustomizeController extends GetxController {

  var currentFontSize = 10.0.obs;
  var currentTextColor = "black".obs;
  var currentBackgroundColor = "white".obs;
  var currentFontStyle = "";
  var currentCharacterSpacing = 1.0.obs;
  var currentWordSpacing = 1.0.obs;
  var currentLineSpacing = 1.0.obs;

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
        : -1.0 ;

    currentFontSize.value = fontSize.toDouble();
    update();
  }

  // save value to database when have change from user
  Future<void> saveToDb(String fieldName, double value) async {
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

  List<Color> backgroundColor = [
    Colors.white,
    Colors.yellowAccent,
    Colors.pink,
    Colors.blue
  ];

  List<String> backgroundColor_text = [
    'white',
    'yellow',
    'pink',
    'blue'
  ];




}
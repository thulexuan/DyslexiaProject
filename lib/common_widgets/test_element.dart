import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestElementWidget extends StatelessWidget {

  String word;
  double fontSize;
  String fontFamily;
  double letterSpacing;
  double wordSpacing;
  bool isSelected;

  TestElementWidget({
    required this.word,
    required this.fontSize,
    required this.fontFamily,
    required this.letterSpacing,
    required this.wordSpacing,
    required this.isSelected,
});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
                //color: Colors.black.withOpacity(0.1),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  word,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: fontFamily,
                      letterSpacing: letterSpacing,
                       wordSpacing: wordSpacing,
                  ),
                ),
              ),
          SizedBox(height: 30,),
        ],
      );
  }
}

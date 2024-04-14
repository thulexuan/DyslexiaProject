import 'dart:math';

import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/questionItem.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/testElementItem.dart';
import 'package:dyslexia_project/modules/common/views/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/testElement.dart';
import '../../customizeText/controllers/text_customize_controller.dart';

class TestLetterPage extends StatefulWidget {

  @override
  State<TestLetterPage> createState() => _TestLetterPageState();

  String letter;
  int OuesNum;

  TestLetterPage({super.key,
    required this.letter,
    required this.OuesNum
});

}

class _TestLetterPageState extends State<TestLetterPage> {

  final testController = Get.put(TestController());
  final textCustomizeController = Get.put(TextCustomizeController());
  late List<int> position;

  int selectedIndex = -1;

  List<int> generateArray() {
    Random random = Random();
    List<int> array = List<int>.generate(4, (index) => random.nextInt(4));

    // Ensure none of the elements are equal
    while (!isUnique(array)) {
      array = List<int>.generate(4, (index) => random.nextInt(4));
    }

    return array;
  }

  bool isUnique(List<int> array) {
    for (int i = 0; i < array.length; i++) {
      for (int j = i + 1; j < array.length; j++) {
        if (array[i] == array[j]) {
          return false;
        }
      }
    }
    return true;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    position = generateArray();
  }

  @override
  Widget build(BuildContext context) {
    print(position);
    List<TestElement> letters = [
      TestElement(word: widget.letter, fontSize: 24, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.letter, fontSize: 35, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.letter, fontSize: 24, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.letter, fontSize: 35, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
    ];

    List<List<double>> positionValue = [
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 0.6 / 3],
      [MediaQuery.of(context).size.height / 2.2 + 200, MediaQuery.of(context).size.width * 0.6 / 3],
      [MediaQuery.of(context).size.height / 2.2 + 200, MediaQuery.of(context).size.width * 2 / 3],
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 2 / 3]
    ];



    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10,),
              QuestionItem(question: 'Hãy chọn chữ bạn cho là dễ nhìn nhất',),
              SizedBox(height: MediaQuery.of(context).size.height / 8,),
            ],
          ),
          // display choices
          Positioned(
            top: positionValue[position[0]][0],
            left: positionValue[position[0]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
                testController.answers[widget.OuesNum] = 3;
              },
              child: TestElementItem(
                word: letters[3].word,
                fontSize: letters[3].fontSize,
                letterSpacing: letters[3].letterSpacing,
                wordSpacing: letters[3].wordSpacing,
                isSelected: selectedIndex == 3 ? true : false,
                fontFamily: letters[3].fontFamily,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[1]][0],
            left: positionValue[position[1]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                testController.answers[widget.OuesNum] = 2;
              },
              child: TestElementItem(
                word: letters[2].word,
                fontSize: letters[2].fontSize,
                letterSpacing: letters[2].letterSpacing,
                wordSpacing: letters[2].wordSpacing,
                isSelected: selectedIndex == 2 ? true : false,
                fontFamily: letters[2].fontFamily,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[2]][0],
            left: positionValue[position[2]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                testController.answers[widget.OuesNum] = 1;
              },
              child: TestElementItem(
                word: letters[1].word,
                fontSize: letters[1].fontSize,
                letterSpacing: letters[1].letterSpacing,
                wordSpacing: letters[1].wordSpacing,
                isSelected: selectedIndex == 1 ? true : false,
                fontFamily: letters[1].fontFamily,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[3]][0],
            left: positionValue[position[3]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                testController.answers[widget.OuesNum] = 0;
              },
              child: TestElementItem(
                word: letters[0].word,
                fontSize: letters[0].fontSize,
                letterSpacing: letters[0].letterSpacing,
                wordSpacing: letters[0].wordSpacing,
                isSelected: selectedIndex == 0 ? true : false,
                fontFamily: letters[0].fontFamily,
              ),
            ),
          ),
      ]
      ),
    );
  }
}

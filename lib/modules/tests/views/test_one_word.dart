import 'dart:math';

import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/questionItem.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/testElementItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../models/testElement.dart';

class TestOneWordPage extends StatefulWidget {

  @override
  State<TestOneWordPage> createState() => _TestOneWordPageState();

  String word;
  final quesNum;

  TestOneWordPage({
    required this.word,
    required this.quesNum
});
}

class _TestOneWordPageState extends State<TestOneWordPage> {

  final testController = Get.put(TestController());
  int selectedIndex = -1;

  late List<int> position;
  
  List<int> generateArray() {
    Random random = Random();
    List<int> array = List<int>.generate(6, (index) => random.nextInt(6));

    // Ensure none of the elements are equal
    while (!isUnique(array)) {
      array = List<int>.generate(6, (index) => random.nextInt(6));
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

    List<TestElement> words  = [
      TestElement(word: widget.word, fontSize: 24, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Arial', letterSpacing: 5, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 24, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Times New Roman', letterSpacing: 5, wordSpacing: 0, isSelected: false,),

    ];

    List<List<double>> positionValue = [
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width / 2 - 250],
      [MediaQuery.of(context).size.height / 1.7, MediaQuery.of(context).size.width / 2 - 250],
      [MediaQuery.of(context).size.height / 1.4, MediaQuery.of(context).size.width / 2 - 250],
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width / 2 + 100],
      [MediaQuery.of(context).size.height / 1.7, MediaQuery.of(context).size.width / 2 + 100],
      [MediaQuery.of(context).size.height / 1.4, MediaQuery.of(context).size.width / 2 + 100],
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
          Positioned(
            top: positionValue[position[0]][0],
            left: positionValue[position[0]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                testController.answers[widget.quesNum] = 0;
              },
              child: TestElementItem(
                word: words[0].word,
                fontSize: words[0].fontSize,
                letterSpacing: words[0].letterSpacing,
                wordSpacing: words[0].wordSpacing,
                isSelected: selectedIndex == 0 ? true : false,
                fontFamily: words[0].fontFamily,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[1]][0],
            left: positionValue[position[1]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                testController.answers[widget.quesNum] = 1;
              },
              child: TestElementItem(
                word: words[1].word,
                fontSize: words[1].fontSize,
                letterSpacing: words[1].letterSpacing,
                wordSpacing: words[1].wordSpacing,
                isSelected: selectedIndex == 1 ? true : false,
                fontFamily: words[1].fontFamily,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[2]][0],
            left: positionValue[position[2]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                testController.answers[widget.quesNum] = 2;
              },
              child: TestElementItem(
                word: words[2].word,
                fontSize: words[2].fontSize,
                letterSpacing: words[2].letterSpacing,
                wordSpacing: words[2].wordSpacing,
                isSelected: selectedIndex == 2 ? true : false,
                fontFamily: words[2].fontFamily,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[3]][0],
            left: positionValue[position[3]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
                testController.answers[widget.quesNum] = 3;
              },
              child: TestElementItem(
                word: words[3].word,
                fontSize: words[3].fontSize,
                letterSpacing: words[3].letterSpacing,
                wordSpacing: words[3].wordSpacing,
                isSelected: selectedIndex == 3 ? true : false,
                fontFamily: words[3].fontFamily,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[4]][0],
            left: positionValue[position[4]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 4;
                });
                testController.answers[widget.quesNum] = 4;
              },
              child: TestElementItem(
                word: words[4].word,
                fontSize: words[4].fontSize,
                letterSpacing: words[4].letterSpacing,
                wordSpacing: words[4].wordSpacing,
                isSelected: selectedIndex == 4 ? true : false,
                fontFamily: words[4].fontFamily,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[5]][0],
            left: positionValue[position[5]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 5;
                });
                testController.answers[widget.quesNum] = 5;
              },
              child: TestElementItem(
                word: words[5].word,
                fontSize: words[5].fontSize,
                letterSpacing: words[5].letterSpacing,
                wordSpacing: words[5].wordSpacing,
                isSelected: selectedIndex == 5 ? true : false,
                fontFamily: words[5].fontFamily,
              ),
            ),
          ),
        ]
      ),
    );



  }
}

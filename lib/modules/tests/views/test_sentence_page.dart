import 'dart:math';

import 'package:dyslexia_project/common_widgets/test_element.dart';
import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/sentence_item.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/testElementItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/testElement.dart';
import 'common_widgets/questionItem.dart';

class TestSentencePage extends StatefulWidget {

  @override
  State<TestSentencePage> createState() => _TestSentencePageState();

  String sentence;
  int quesNum;
  double fontSize;

  TestSentencePage({
    required this.sentence,
    required this.quesNum,
    required this.fontSize
});

}

class _TestSentencePageState extends State<TestSentencePage> {

  final testController = Get.put(TestController());
  int selectedIndex = -1;

  late List<int> position;

  List<int> generateArray() {
    Random random = Random();
    List<int> array = List<int>.generate(2, (index) => random.nextInt(2));

    // Ensure none of the elements are equal
    while (!isUnique(array)) {
      array = List<int>.generate(2, (index) => random.nextInt(2));
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

    List<TestElement> sentences  = [
      TestElement(word: widget.sentence, fontSize: 24, fontFamily: "Arial", letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 24, fontFamily: "Times New Roman", letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 35, fontFamily: "Arial", letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 35, fontFamily: "Times New Roman", letterSpacing: 0, wordSpacing: 0, isSelected: false,),
    ];

    List<List<double>> positionValue = [
      [MediaQuery.of(context).size.height / 2, MediaQuery.of(context).size.width / 2 - 400],
      [MediaQuery.of(context).size.height / 2, MediaQuery.of(context).size.width / 2 + 100],
    ];
    print(position);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10,),
              QuestionItem(question: 'Hãy chọn câu bạn cho là dễ nhìn nhất',),
              SizedBox(height: 10,),
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
              child: SentenceItem(
                  sentence: widget.sentence,
                  fontFamily: 'Arial',
                  fontSize: widget.fontSize,
                  isSelected: selectedIndex == 0 ? true : false
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
              child: SentenceItem(
                  sentence: widget.sentence,
                  fontFamily: 'Times New Roman',
                  fontSize: widget.fontSize,
                  isSelected: selectedIndex == 1 ? true : false
              ),
            ),
          ),
        ]
      )
    );
  }
}

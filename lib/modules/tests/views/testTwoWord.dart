import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/questionItem.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/testElementItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common_widgets/test_element.dart';
import '../../../models/testElement.dart';

class TestTwoWordPage extends StatefulWidget {

  @override
  State<TestTwoWordPage> createState() => _TestTwoWordPageState();

  String word;
  int quesNum;

  TestTwoWordPage({
    required this.word,
    required this.quesNum
  });
}

class _TestTwoWordPageState extends State<TestTwoWordPage> {

  final testController = Get.put(TestController());
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {

    List<TestElement> words  = [
      TestElement(word: widget.word, fontSize: 24, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 24, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 21, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 21, isSelected: false,),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            QuestionItem(question: 'Hãy chọn chữ bạn cho là dễ nhìn nhất',),
            SizedBox(height: 10,),
            Column(
              children: [
                GestureDetector(
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
                GestureDetector(
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
                GestureDetector(
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
                GestureDetector(
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
                GestureDetector(
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
                GestureDetector(
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
              ],
            )
          ],
        ),
      ),
    );
  }
}

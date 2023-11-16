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

  @override
  Widget build(BuildContext context) {

    List<TestElement> sentences  = [
      TestElement(word: widget.sentence, fontSize: 24, fontFamily: "Arial", letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 24, fontFamily: "Times New Roman", letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 35, fontFamily: "Arial", letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 35, fontFamily: "Times New Roman", letterSpacing: 0, wordSpacing: 0, isSelected: false,),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 10,),
                QuestionItem(question: 'Hãy chọn câu bạn cho là dễ nhìn nhất',),
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
                      child: SentenceItem(
                          sentence: widget.sentence,
                          fontFamily: 'Arial',
                          fontSize: widget.fontSize,
                          isSelected: selectedIndex == 0 ? true : false
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       selectedIndex = 1;
                    //     });
                    //     testController.answers[widget.quesNum] = 1;
                    //   },
                    //   child: SentenceItem(
                    //       sentence: widget.sentence,
                    //       fontFamily: sentences[1].fontFamily,
                    //       fontSize: sentences[1].fontSize,
                    //       isSelected: selectedIndex == 1 ? true : false
                    //   ),
                    // ),
                    GestureDetector(
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
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       selectedIndex = 3;
                    //     });
                    //     testController.answers[widget.quesNum] = 3;
                    //   },
                    //   child: SentenceItem(
                    //       sentence: widget.sentence,
                    //       fontFamily: sentences[3].fontFamily,
                    //       fontSize: sentences[3].fontSize,
                    //       isSelected: selectedIndex == 3 ? true : false
                    //   ),
                    // )
                  ],
                )
              ],
            ),
      )
    );
  }
}

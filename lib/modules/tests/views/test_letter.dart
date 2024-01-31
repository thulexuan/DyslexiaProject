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

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<TestElement> letters = [
      TestElement(word: widget.letter, fontSize: 24, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.letter, fontSize: 35, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.letter, fontSize: 24, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.letter, fontSize: 35, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10,),
            QuestionItem(question: 'Hãy chọn chữ bạn cho là dễ nhìn nhất',),
            SizedBox(height: MediaQuery.of(context).size.height / 8,),
            
            // display choices

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    // GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         selectedIndex = 0;
                    //       });
                    //       testController.answers[widget.OuesNum] = 0;
                    //     },
                    //     child: Text(letters[0].word, style: TextStyle(fontSize: letters[0].fontSize, fontFamily: letters[0].fontFamily, letterSpacing: letters[0].letterSpacing, wordSpacing: letters[0].wordSpacing, color: selectedIndex == 0 ? Colors.red : Colors.black),)
                    // ),
                    GestureDetector(
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
                    SizedBox(height: 40,),
                    GestureDetector(
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
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
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
                    SizedBox(height: 40,),
                    GestureDetector(
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
                  ],
                )
              ],
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}

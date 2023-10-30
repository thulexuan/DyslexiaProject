import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/testTwoWord.dart';
import 'package:dyslexia_project/modules/tests/views/test_letter.dart';
import 'package:dyslexia_project/modules/tests/views/test_mirror_letter.dart';
import 'package:dyslexia_project/modules/tests/views/test_one_word.dart';
import 'package:dyslexia_project/modules/tests/views/test_sentence_page.dart';
import 'package:dyslexia_project/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  final PageController _pageController = PageController();
  final testController = Get.put(TestController());
  final textCustomizeController = Get.put(TextCustomizeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          TestLetterPage(letter: 'ă', OuesNum: 0,),
          TestLetterPage(letter: 'm', OuesNum: 1,),
          TestLetterPage(letter: 't', OuesNum: 2,),
          // TestOneWordPage(word: 'cũ',),
          // TestOneWordPage(word: 'tỏ',),
          // TestOneWordPage(word: 'làm',),
          // TestTwoWordPage(word: 'cái kéo'),
          // TestTwoWordPage(word: 'bút chì'),
          // TestTwoWordPage(word: 'xe đạp'),
          // TestSentencePage(fontFamily: 'Arial'),
          // TestSentencePage(fontFamily: 'Times New Roman'),
          // TestMirrorPage()
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // ElevatedButton(
          //   onPressed: previousPage,
          //   child: Text('Previous'),
          // ),
          ElevatedButton(
            onPressed: nextPage,
            child: Text('Tiếp tục'),
          )
        ],
      ),
    );
  }

  Future<void> nextPage() async {
    if (_pageController.page?.toInt() == 2) {
      testController.process();
      await textCustomizeController.getData();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OverviewPage()),
      );
    } else {
      _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn
      );
    }

    print(testController.answers);
  }

  // void previousPage(){
  //   _pageController.previousPage(
  //       duration: Duration(milliseconds: 400),
  //       curve: Curves.easeIn
  //   );
  //}
}

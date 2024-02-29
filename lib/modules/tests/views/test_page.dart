import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/testTwoWord.dart';
import 'package:dyslexia_project/modules/tests/views/test_letter.dart';
import 'package:dyslexia_project/modules/tests/views/test_mirror_letter.dart';
import 'package:dyslexia_project/modules/tests/views/test_one_word.dart';
import 'package:dyslexia_project/modules/tests/views/test_sentence_page.dart';
import 'package:dyslexia_project/modules/common/views/overview_page.dart';
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
          TestOneWordPage(word: 'cũ', quesNum: 3,),
          TestOneWordPage(word: 'tỏ', quesNum: 4,),
          TestOneWordPage(word: 'làm', quesNum: 5,),
          TestTwoWordPage(word: 'cái kéo', quesNum: 6,),
          TestTwoWordPage(word: 'bút chì', quesNum: 7,),
          TestTwoWordPage(word: 'xe đạp', quesNum: 8,),
          TestSentencePage(fontSize: 24, sentence: 'Câu này không nghĩa', quesNum: 9,),
          TestSentencePage(fontSize: 35, sentence: 'Câu này không nghĩa', quesNum: 10,),
          TestMirrorPage(letter: 'd', quesNum: 11,),
          TestMirrorPage(letter: 'q', quesNum: 12,),
          TestMirrorPage(letter: 'n', quesNum: 13,),
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
            onPressed: () async {
              await nextPage();
            },
            child: Row(
              children: [
                Text('Tiếp tục', style: Theme.of(context).textTheme.labelSmall,),
                Icon(Icons.keyboard_double_arrow_right, size: Theme.of(context).iconTheme.size,)
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> nextPage() async {
    if (_pageController.page?.toInt() == 13) {
      print(testController.answers);
      await testController.process();
      await textCustomizeController.getData();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OverviewPage()),
      );
      print(textCustomizeController.currentCharacterSpacing.value);
    } else {
      _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn
      );
    }


  }

  // void previousPage(){
  //   _pageController.previousPage(
  //       duration: Duration(milliseconds: 400),
  //       curve: Curves.easeIn
  //   );
  //}
}

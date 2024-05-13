import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
import 'package:dyslexia_project/modules/exams/views/component/question_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../result_page.dart';

class OneQuestionItem extends StatefulWidget {
  @override
  State<OneQuestionItem> createState() => _OneQuestionItemState();

  int questionNum;
  String examCode;
  List<dynamic> listQuestions;
  PageController pageController;
  EachExamController controller;

  OneQuestionItem(
      {required this.questionNum,
      required this.listQuestions,
      required this.pageController,
      required this.examCode,
        required this.controller
      });
}

class _OneQuestionItemState extends State<OneQuestionItem> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedIndex = -1;
  bool isNextPage = false;
  bool canChooseAnswer = true;
  bool isSuggested = false;

  final textCustomizeController = Get.put(TextCustomizeController());
  FlutterTts tts = FlutterTts();


  String suggestedPara = '';
  String keySentence = '';

  String beforeText = '';
  String afterText = '';
  String textInside = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suggestedPara = widget.listQuestions[widget.questionNum]['suggestedPara'];
    keySentence = widget.listQuestions[widget.questionNum]['keySentence'].toString().trim();
    int index = suggestedPara.indexOf(keySentence);
    beforeText = suggestedPara.substring(0, index);
    textInside = suggestedPara.substring(index, index + keySentence.length);
    afterText = suggestedPara.substring(index + keySentence.length, suggestedPara.length);

    print(widget.controller.listCorrectAnswer.value);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PageStorage(
      bucket: PageStorageBucket(),
      child: Obx(() => Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3), // Shadow position (x, y)
                        blurRadius: 5, // Spread of the shadow
                        spreadRadius: 2, // Extends the shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText.rich(
                            TextSpan(
                                children: <TextSpan> [
                                  TextSpan(
                                      text: beforeText
                                  ),
                                  TextSpan(
                                      text: textInside,
                                      style: isSuggested ? TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.red)
                                          : TextStyle(decoration: TextDecoration.none)
                                  ),
                                  TextSpan(
                                      text: afterText
                                  )
                                ]
                            ),
                            onSelectionChanged: (TextSelection selection, SelectionChangedCause? cause) {
                              tts.setLanguage('vi-VN');
                              tts.speak(suggestedPara.substring(selection.baseOffset, selection.extentOffset));
                            },
                            contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {

                              final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
                              buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                                return buttonItem.type == ContextMenuButtonType.cut;
                              });
                              buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                                return buttonItem.type == ContextMenuButtonType.copy;
                              });
                              buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                                return buttonItem.type == ContextMenuButtonType.selectAll;
                              });
                              buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                                return buttonItem.type == ContextMenuButtonType.paste;
                              });
                              return AdaptiveTextSelectionToolbar.buttonItems(
                                anchors: editableTextState.contextMenuAnchors,
                                buttonItems: buttonItems,
                              );
                            },
                            style: TextStyle(
                                color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                                fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                fontFamily: textCustomizeController.currentFontStyle.value,
                                letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                height: textCustomizeController.currentLineSpacing.value.toDouble()
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.volume_up, color: Colors.teal,), onPressed: () {
                                List<String> sentences = suggestedPara.split('\n');
                                for (int i = 0; i < sentences.length; i++) {
                                  SoundFunction().speakFast(
                                      suggestedPara,
                                      textCustomizeController.current_volume.value,
                                      textCustomizeController.current_rate.value,
                                      textCustomizeController.current_pitch.value,
                                      textCustomizeController.current_voice_name.value,
                                      suggestedPara.split(' '),
                                      0);
                                }
                            },
                            ),
                            IconButton(
                              icon: Icon(Icons.lightbulb, color: Colors.teal,), onPressed: () {
                                setState(() {
                                  isSuggested = !isSuggested;
                                });
                            },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 5 - 20,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 3), // Shadow position (x, y)
                                    blurRadius: 5, // Spread of the shadow
                                    spreadRadius: 2, // Extends the shadow
                                  ),
                                ],
                                color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.listQuestions[widget.questionNum]
                                      ['questionDetail'],
                                      style: TextStyle(
                                          color: textCustomizeController.textColor.elementAt(
                                              textCustomizeController.textColor_text.indexOf(
                                                  textCustomizeController
                                                      .currentTextColor.value)),
                                          fontSize: textCustomizeController
                                              .currentFontSize.value
                                              .toDouble(),
                                          fontFamily:
                                          textCustomizeController.currentFontStyle.value,
                                          letterSpacing: textCustomizeController
                                              .currentCharacterSpacing.value
                                              .toDouble(),
                                          wordSpacing: textCustomizeController
                                              .currentWordSpacing.value
                                              .toDouble(),
                                          height: textCustomizeController
                                              .currentLineSpacing.value
                                              .toDouble(),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        SoundFunction().speakFast(
                                            widget.listQuestions[widget.questionNum]['questionDetail'],
                                            textCustomizeController.current_volume.value,
                                            textCustomizeController.current_rate.value,
                                            textCustomizeController.current_pitch.value,
                                            textCustomizeController.current_voice_name.value,
                                            suggestedPara.split(' '),
                                            0);
                                      },
                                      icon: Icon(Icons.volume_up,)
                                  )
                                ],
                              ),
                            ),

                            // 3 options here

                            GestureDetector(
                                onTap: () {
                                  canChooseAnswer
                                      ? {
                                    setState(() {
                                      selectedIndex = 0;
                                    }),
                                    widget.controller
                                        .listUserAnswer[widget.questionNum] = 0,
                                  }
                                      : null;
                                },
                                child: QuestionOption(
                                  isSelected: selectedIndex == 0 ? true : false,
                                  content: widget.listQuestions[widget.questionNum]
                                  ['options'][0],
                                )),
                            GestureDetector(
                                onTap: () {
                                  canChooseAnswer
                                      ? {
                                    setState(() {
                                      selectedIndex = 1;
                                    }),
                                    widget.controller
                                        .listUserAnswer.value[widget.questionNum] = 1,
                                  }
                                      : null;
                                },
                                child: QuestionOption(
                                  isSelected: selectedIndex == 1 ? true : false,
                                  content: widget.listQuestions[widget.questionNum]
                                  ['options'][1],
                                )),
                            GestureDetector(
                                onTap: () {
                                  canChooseAnswer
                                      ? {
                                    setState(() {
                                      selectedIndex = 2;
                                    }),
                                    widget.controller
                                        .listUserAnswer[widget.questionNum] = 2
                                  }
                                      : null;
                                },
                                child: QuestionOption(
                                  isSelected: selectedIndex == 2 ? true : false,
                                  content: widget.listQuestions[widget.questionNum]
                                  ['options'][2],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            checkAnswer(widget.questionNum, selectedIndex);
                            setState(() {
                              isNextPage = true;
                              canChooseAnswer = false;
                            });
                          },
                          child: isNextPage ? Text('Tiếp tục') : Text('Kiểm tra')),
                    )
                  ],
                ),
              ),
          )
        ],
      )),
    );
  }

  Future<void> checkAnswer(int questionNumber, int userAnswer) async {
    if (!isNextPage) {
      // get correct answer of current question
      int correctAnswer = widget.controller.listCorrectAnswer.value
          .elementAt(questionNumber);
      print(correctAnswer);
      print(userAnswer);

      // compare with userAnser
      bool isCorrect = userAnswer == correctAnswer;
      // if answer correct -> show effect
      if (isCorrect) {
        AudioPlayer().play(AssetSource('sounds/success.mp3'));
        showSuccessGif(context);
      } else {
        AudioPlayer().play(AssetSource('sounds/incorrect.mp3'));
        showSadGif(context);
      }
    } else {
      if (widget.pageController.page?.toInt() ==
          widget.controller.listQuestions.length - 1) {
        await widget.controller.resultProcess();
        await widget.controller.saveDoneExamToDb(widget.examCode);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultPage(
                    totalQues: widget.controller.listQuestions.length,
                    numCorrectAns: widget.controller.numOfCorrect.value, controller: widget.controller,
                  )),
        );
      } else {
        widget.pageController.nextPage(
            duration: Duration(milliseconds: 400), curve: Curves.easeIn);
      }
    }
  }

  void showSuccessGif(BuildContext context) {
    Navigator.of(context).push(
      DialogRoute<void>(
          context: context,
          builder: (BuildContext context) => Dialog(
              child: Container(
                  height: 500,
                  width: 500,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/well_done_gif_1.gif',
                        ),
                        Text('Bạn làm đúng rồi')
                      ])))),
    );
  }

  void showSadGif(BuildContext context) {
    Navigator.of(context).push(
      DialogRoute<void>(
          context: context,
          builder: (BuildContext context) => Dialog(
              child: Container(
                  height: 500,
                  width: 550,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: 400,
                          height: 300,
                          child: Image.asset(
                            'assets/images/sad_1.gif',
                            fit: BoxFit.cover,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Không đúng rồi! Hãy thử lại nào!'),
                      )
                    ],
                  )))),
    );
  }
}

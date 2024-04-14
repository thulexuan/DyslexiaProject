import 'package:dyslexia_project/common_widgets/custom_text_widget.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/each_exam_controller.dart';

class ReviewEachQuestion extends StatelessWidget {

  String userAnswer;
  String correctAnswer;
  int questionNum;
  EachExamController controller;

  ReviewEachQuestion({
    required this.userAnswer,
    required this.correctAnswer,
    required this.questionNum,
    required this.controller
});

  final textCustomizeController = Get.put(TextCustomizeController());

  @override
  Widget build(BuildContext context) {
    textCustomizeController.getData();
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Câu ${questionNum+1} : ',
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                  TextSpan(
                    text: (userAnswer == correctAnswer ? 'Đúng' : 'Sai'),
                    style: TextStyle(fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 20 : MediaQuery.of(context).size.height / 20, fontWeight: FontWeight.bold, color: userAnswer == correctAnswer ? Colors.green : Colors.red)
                  )
                ]
              )
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text('Đáp án bạn chọn : ' + userAnswer, style: Theme.of(context).textTheme.bodyMedium,),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text('Đáp án đúng : ' + correctAnswer, style: Theme.of(context).textTheme.bodyMedium),
          ),
          ElevatedButton(onPressed: () {
            showQuestion(questionNum, context);
          }, child: Text('Xem')),
          Divider(thickness: 5,),
        ],
      ),
    );
  }

  void showQuestion(int questionNumber, BuildContext context) {

    String suggestedPara = controller.listQuestions[questionNumber]['suggestedPara'];
    String keySentence = controller.listQuestions[questionNumber]['keySentence'].toString().trim();
    int index = suggestedPara.indexOf(keySentence);
    String beforeText = suggestedPara.substring(0, index);
    String textInside = suggestedPara.substring(index, index + keySentence.length);
    String afterText = suggestedPara.substring(index + keySentence.length, suggestedPara.length);

    Navigator.of(context).push(
      DialogRoute<void>(
          context: context,
          builder: (BuildContext context) =>
              Dialog(
                  child: Container(
                      height: 500,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  child: SelectableText.rich(
                                    TextSpan(
                                      children: <TextSpan> [
                                        TextSpan(
                                          text: beforeText
                                        ),
                                        TextSpan(
                                            text: textInside,
                                            style: TextStyle(
                                              decorationColor: Colors.red,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: afterText
                                        ),
                                      ]
                                    ),
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
                                        color: textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(textCustomizeController.currentOpacity.value)
                                            : textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                                        fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                        fontFamily: textCustomizeController.currentFontStyle.value,
                                        letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                        wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                        height: textCustomizeController.currentLineSpacing.value.toDouble() + 1
                                    ),
                                  )
                              )
                          ),
                          VerticalDivider(thickness: 5,),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(controller.listQuestions[questionNumber]['questionDetail'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                        fontFamily: textCustomizeController.currentFontStyle.value,
                                        letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                        wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                        height: textCustomizeController.currentLineSpacing.value.toDouble()
                                    ),
                                  ),
                                  SizedBox(height: 30,),
                                  for (int i=0; i<3; i++)
                                    CustomText(controller.listQuestions[questionNumber]['options'][i],
                                      isSelected: i == controller.listCorrectAnswer[questionNumber],
                                      normalStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                          fontFamily: textCustomizeController.currentFontStyle.value,
                                          letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                          wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                          height: textCustomizeController.currentLineSpacing.value.toDouble()
                                      ),
                                      selectedStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                          fontFamily: textCustomizeController.currentFontStyle.value,
                                          letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                          wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                          height: textCustomizeController.currentLineSpacing.value.toDouble()
                                      ),
                                    )

                                ],
                              ),
                            ),
                          ),

                        ],

                      )

                  )
              )
      ),
    );
  }
}

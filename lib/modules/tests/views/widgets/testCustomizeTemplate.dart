import 'package:dyslexia_project/models/customizeTextQuestion.dart';
import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/widgets/testOption.dart';
import 'package:flutter/material.dart';

import '../../../../data/CustomizeTextQuestion.dart';
import 'package:get/get.dart';

class TestCustomizeTemplate extends StatefulWidget {

  CustomizeTextQuestion question;
  int questionIndex;


  TestCustomizeTemplate({
    required this.question,
    required this.questionIndex
});

  @override
  State<TestCustomizeTemplate> createState() => _TestCustomizeTemplateState();
}

class _TestCustomizeTemplateState extends State<TestCustomizeTemplate> {

  final controller = Get.put(TestController());

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.question.question!),
          SizedBox(height: 40,),
          GestureDetector(
              onTap: () {
                controller.updateSelectedOption(widget.questionIndex, 0);
                controller.selectedOption.refresh();
              },
            child: TestOption(
              content: widget.question.content,
              size: widget.question.options![0].fontSize,
              characterSpacing: widget.question.options![0].characterSpacing,
              index: 0, questionIndex: widget.questionIndex,
            )
          ),
          SizedBox(height: 40,),
          GestureDetector(
            onTap: () {
              controller.updateSelectedOption(widget.questionIndex, 1);
              controller.selectedOption.refresh();
            },
            child: TestOption(
              content: widget.question.content,
              size: widget.question.options![1].fontSize,
              characterSpacing: widget.question.options![1].characterSpacing,
              index: 1, questionIndex: widget.questionIndex,
            )
          ),
          SizedBox(height: 40,),
          GestureDetector(
              onTap: () {
                controller.updateSelectedOption(widget.questionIndex, 2);
                controller.selectedOption.refresh();
              },
              child: TestOption(
                content: widget.question.content,
                size: widget.question.options![2].fontSize,
                characterSpacing: widget.question.options![2].characterSpacing,
                index: 2, questionIndex: widget.questionIndex,
              )
          ),
        ],
      ),
    );
  }
}

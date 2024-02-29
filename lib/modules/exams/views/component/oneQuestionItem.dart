import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
import 'package:dyslexia_project/modules/exams/views/component/question_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OneQuestionItem extends StatefulWidget {

  @override
  State<OneQuestionItem> createState() => _OneQuestionItemState();

  int questionNum;
  List<dynamic> listQuestions;

  OneQuestionItem({
    required this.questionNum,
    required this.listQuestions,
});

}

class _OneQuestionItemState extends State<OneQuestionItem> with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;

  int selectedIndex = -1;
  final each_exam_controller = Get.put(EachExamController());

  @override
  Widget build(BuildContext context) {

    super.build(context);

    return PageStorage(
      bucket: PageStorageBucket(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.listQuestions[widget.questionNum]['questionDetail'], style: Theme.of(context).textTheme.bodyLarge,),

            // 3 options here

            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  each_exam_controller.listUserAnswer[widget.questionNum] = 0;
                },
                child: QuestionOption(
                  isSelected: selectedIndex == 0 ? true : false,
                  content: widget.listQuestions[widget.questionNum]['options'][0],
                )
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  each_exam_controller.listUserAnswer[widget.questionNum] = 1;
                },
                child: QuestionOption(
                  isSelected: selectedIndex == 1 ? true : false,
                  content: widget.listQuestions[widget.questionNum]['options'][1],
                )
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  each_exam_controller.listUserAnswer[widget.questionNum] = 2;
                },
                child: QuestionOption(
                  isSelected: selectedIndex == 2 ? true : false,
                  content: widget.listQuestions[widget.questionNum]['options'][2],
                )
            ),
          ],
        ),
      ),
    );
  }
}

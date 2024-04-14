import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
import 'package:dyslexia_project/modules/exams/views/component/oneQuestionItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamDetailPageNew extends StatefulWidget {

  String examCode;

  ExamDetailPageNew({
    required this.examCode
});

  @override
  State<ExamDetailPageNew> createState() => _ExamDetailPageNewState();
}

class _ExamDetailPageNewState extends State<ExamDetailPageNew> {

  // List<dynamic> listQuestions = [];
  PageController pageController = PageController();
  EachExamController eachExamController = EachExamController();

  @override
  void initState() {
    super.initState();
    // getExamDetail(widget.examCode);
    eachExamController.getExamDetail(widget.examCode);
    print(eachExamController.listQuestions.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bài kiểm tra', style: Theme.of(context).textTheme.labelSmall,),
      toolbarHeight: MediaQuery.of(context).size.height / 12,),
      body: Obx(() => PageView.builder(
          controller: pageController,
          itemCount: eachExamController.listQuestions.length,
          itemBuilder: (context, index) {
            return OneQuestionItem(
                questionNum: index,
                listQuestions: eachExamController.listQuestions,
                pageController: pageController,
                examCode: widget.examCode, controller: eachExamController,
            );
          }
      ),
      ),
    );
  }
}

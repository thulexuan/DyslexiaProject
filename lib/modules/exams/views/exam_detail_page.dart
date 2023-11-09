import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
import 'package:dyslexia_project/modules/exams/views/component/oneQuestionItem.dart';
import 'package:dyslexia_project/modules/exams/views/result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/controllers/user_controller.dart';

class ExamDetailPage extends StatefulWidget {

  int examNumber;

  ExamDetailPage({
    required this.examNumber,
});

  @override
  State<ExamDetailPage> createState() => _ExamDetailPageState();
}

class _ExamDetailPageState extends State<ExamDetailPage> {

  final PageController controller = PageController();
  final each_exam_controller = Get.put(EachExamController());
  final userController = Get.put(UserController());

  String long_text = '';
  List<dynamic> listQuestions = [];
  List<dynamic> doneExams = [];
  List<dynamic> resultDoneExams = [];

  Future<void> getDoneExams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',
        isEqualTo: prefs.getString('email')) // add your condition here
        .get();

    // get data from the first document in the snapshot
    final Object? data =
    snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    setState(() {
      doneExams = data != null && data is Map<String, dynamic> ? data['doneExams'] : [];
      resultDoneExams = data != null && data is Map<String, dynamic> ? data['resultDoneExams'] : [];
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getExamDetail();
    each_exam_controller.getExamDetail(widget.examNumber);
    getDoneExams();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Bài kiểm tra số ' + (widget.examNumber+1).toString()),),
      body: Column(
        children: [

          // Text is here

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 3), // Shadow position (x, y)
                      blurRadius: 5, // Spread of the shadow
                      spreadRadius: 2, // Extends the shadow
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Obx(() => Text(each_exam_controller.long_text.value)),
                    )
                ),
              ),
            ),
          ),

          // questions here

          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text('Trả lời các câu hỏi sau'),
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 120,
                    child: Obx(() => PageView.builder(
                      controller: controller,
                      // onPageChanged: (int page) {
                      //   setState(() {
                      //     _currentPage = page;
                      //   });
                      // },
                      itemCount: each_exam_controller.listQuestions.value.length,
                      itemBuilder: (context, index) {
                        return OneQuestionItem(questionNum: index, listQuestions: each_exam_controller.listQuestions.value,);
                      },
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => previousPage(),
                          child: Icon(Icons.keyboard_double_arrow_left)
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                          onPressed: () => nextPage(),
                          child: Icon(Icons.keyboard_double_arrow_right)
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> nextPage() async {
    if (controller.page?.toInt() == each_exam_controller.listQuestions.length - 1) {
      await each_exam_controller.resultProcess();

      // neu khong co examNumber trong doneExams thi add vao list => add ca resultDoneExams.
      // Neu co roi thi thoi thao tac o examNumber -> update resultDoneExams
      if (!doneExams.contains(widget.examNumber)) {
        doneExams.add(widget.examNumber);
        resultDoneExams.add(each_exam_controller.numOfCorrect.value / each_exam_controller.listQuestions.length);
        userController.saveToDb('doneExams', doneExams);
        userController.saveToDb('resultDoneExams', resultDoneExams);
      } else {
        // tim stt cua examNum trong mang doneExam
        var index = doneExams.indexOf(widget.examNumber);
        // update resultDoneExams -> save to db
        resultDoneExams[index] = each_exam_controller.numOfCorrect.value / each_exam_controller.listQuestions.length;
        userController.saveToDb('resultDoneExams', resultDoneExams);
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(totalQues: each_exam_controller.listQuestions.length, numCorrectAns: each_exam_controller.numOfCorrect.value,)),
      );
    } else {
      controller.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn
      );
    }
  }

  Future<void> previousPage() async {
    controller.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn
    );
  }
}

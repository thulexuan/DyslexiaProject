import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
import 'package:dyslexia_project/modules/exams/views/component/review_each_question.dart';
import 'package:dyslexia_project/modules/exams/views/exam_collection_page.dart';
import 'package:dyslexia_project/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultPage extends StatefulWidget {

  int totalQues;
  int numCorrectAns;

  ResultPage({
    required this.totalQues,
    required this.numCorrectAns
});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final each_exam_controller = Get.put(EachExamController());
  bool isViewResultDetail = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isViewResultDetail = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Kết quả'),),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 10.0,
                percent: widget.numCorrectAns / widget.totalQues,
                center: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Tỷ lệ đúng ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      const TextSpan(
                        text: "\n"
                      ),
                      TextSpan(
                        text: "${((widget.numCorrectAns / widget.totalQues) * 100).ceil()}%",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                progressColor: Colors.green,
              ),
            ),
          ),

          Text('Tổng số câu : ' + widget.totalQues.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
          Text('Số câu đúng : ' + widget.numCorrectAns.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isViewResultDetail = !isViewResultDetail;
                });
                print(isViewResultDetail);
              },
              child: Text('Xem chi tiết đáp án')
          ),
          isViewResultDetail == true ? Expanded(
            child: Obx(() => ListView.builder(
              itemCount: each_exam_controller.listQuestions.length,
              itemBuilder: (BuildContext context, int index) {
                return ReviewEachQuestion(
                    userAnswer: each_exam_controller.listUserAnswer[index] == -1 ? 'Không trả lời' : each_exam_controller.listQuestions[index]['options'][each_exam_controller.listUserAnswer[index]],
                    correctAnswer: each_exam_controller.listQuestions[index]['options'][each_exam_controller.listCorrectAnswer[index]],
                    questionNum: index
                );
              },
            )
            ),
          ) : Container(),
          ElevatedButton(
              onPressed: () {
                Get.to(OverviewPage());
              },
              child: Text('Thoát')
          )
        ],
      )

    );
  }
}

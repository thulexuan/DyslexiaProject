import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
import 'package:dyslexia_project/modules/exams/views/component/review_each_question.dart';
import 'package:dyslexia_project/modules/exams/views/exam_collection_page.dart';
import 'package:dyslexia_project/modules/common/views/overview_page.dart';
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
      appBar: AppBar(title: Text('Kết quả', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
              child: CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width / 6,
                lineWidth: 10.0,
                percent: widget.numCorrectAns / widget.totalQues,
                center: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Tỷ lệ đúng ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const TextSpan(
                        text: "\n"
                      ),
                      TextSpan(
                        text: "${((widget.numCorrectAns / widget.totalQues) * 100).ceil()}%",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                progressColor: Colors.green,
              ),
            ),
          ),

          Text('Tổng số câu : ' + widget.totalQues.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          Text('Số câu đúng : ' + widget.numCorrectAns.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isViewResultDetail = !isViewResultDetail;
                });
                print(isViewResultDetail);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Xem chi tiết đáp án', style: Theme.of(context).textTheme.labelSmall,),
              )
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
          SizedBox(height: MediaQuery.of(context).size.height / 40,),
          ElevatedButton(
              onPressed: () {
                Get.to(OverviewPage());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Thoát', style: Theme.of(context).textTheme.labelSmall,),
              )
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40,),
        ],
      )

    );
  }
}

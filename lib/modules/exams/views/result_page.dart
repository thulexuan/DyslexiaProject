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
  EachExamController controller;

  ResultPage({
    required this.totalQues,
    required this.numCorrectAns,
    required this.controller
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
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(title: Text('Kết quả', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  CircularPercentIndicator(
                      radius: orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 6 : MediaQuery.of(context).size.height / 6,
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
                  SizedBox(height: 50,),
                  Text('Tổng số câu : ' + widget.totalQues.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                  Text('Số câu đúng : ' + widget.numCorrectAns.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: 50,),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(OverviewPage());
                      },
                      child: Text('Thoát')
                  )
                ],
              )
          ),
          Expanded(
              flex: 2,
              child: ListView.builder(
                    itemCount: widget.controller.listQuestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ReviewEachQuestion(
                          userAnswer: widget.controller.listUserAnswer[index] == -1 ? 'Không trả lời' : widget.controller.listQuestions[index]['options'][widget.controller.listUserAnswer[index]],
                          correctAnswer: widget.controller.listQuestions[index]['options'][widget.controller.listCorrectAnswer[index]],
                          questionNum: index, controller: widget.controller,
                      );
                    },
                  )


          )
        ],
      )

    );
  }
}

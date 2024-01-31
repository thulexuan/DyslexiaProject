import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ViewCreatedExam extends StatefulWidget {
  const ViewCreatedExam({Key? key, required this.examCode}) : super(key: key);

  final examCode;

  @override
  State<ViewCreatedExam> createState() => _ViewCreatedExamState();
}

class _ViewCreatedExamState extends State<ViewCreatedExam> {

  var text = '';
  var totalQues = 0;
  var questions = [];
  TextEditingController textController = TextEditingController();
  List<TextEditingController> questionDetailControllers = [];
  List<List<TextEditingController>> optionControllers = [];

  final each_exam_controller = Get.put(EachExamController());

  // load content of examNumber-th exam

  Future<void> getExamDetail() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('examCollection').where('examCode', isEqualTo: widget.examCode).get();

    // get data from the first document in the snapshot
    final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    setState(() {
      text = data != null && data is Map<String, dynamic> ? data['text'] : 'no text' ;
      textController.text = text;
      totalQues = data != null && data is Map<String, dynamic> ? data['totalQues'] : 0 ;
      questions = data != null && data is Map<String, dynamic> ? data['questions'] : [] ;

      for (var i=0;i<totalQues;i++) {
        TextEditingController questionDetailController = TextEditingController();
        questionDetailController.text = questions[i]['questionDetail'];
        questionDetailControllers.add(questionDetailController);
        List<TextEditingController> optionControllerOfOneQues = [];
        for (var j=0;j<3;j++) {
          TextEditingController optionController = TextEditingController();
          optionController.text = questions[i]['options'][j];
          optionControllerOfOneQues.add(optionController);
        }
        optionControllers.add(optionControllerOfOneQues);
      }
    });

    print(questions.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    getExamDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bài kiểm tra được tạo'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bài kiểm tra mã ${widget.examCode}', style: TextStyle(fontWeight: FontWeight.bold,)),
              Text('Văn bản', style: TextStyle(fontWeight: FontWeight.bold,),),
              Container(
                padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text(text)),

                    ],
                  )
              ),
              Text('Câu hỏi', style: TextStyle(fontWeight: FontWeight.bold),),
              for (var i=0;i<totalQues;i++)
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(questions[i]['questionDetail']),
                                // GestureDetector(
                                //     onTap: () {
                                //       showDialog(
                                //           context: context,
                                //           builder: (BuildContext context) {
                                //             return AlertDialog(
                                //               content: TextField(
                                //                 controller: questionDetailControllers[i],
                                //                 maxLines: null,
                                //               ),
                                //               actions: [
                                //                 TextButton(
                                //                     onPressed: () async {
                                //                       setState(() {
                                //                         questions[i]['questionDetail'] = questionDetailControllers[i].text;
                                //                       });
                                //                       Navigator.of(context).pop();
                                //                     },
                                //                     child: Text("Cập nhật")
                                //                 ),
                                //                 TextButton(
                                //                     onPressed: () {
                                //                       Navigator.of(context).pop();
                                //                     },
                                //                     child: Text("Bỏ qua")
                                //                 ),
                                //               ],
                                //             );
                                //           }
                                //       );
                                //     },
                                //     child: Icon(Icons.edit)
                                // ),
                              ],
                            ),
                            Divider(),
                            for (var j=0;j<3;j++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.radio_button_checked),
                                    SizedBox(width: 20,),
                                    Text(questions[i]['options'][j]),

                                  ],
                                ),
                              ),
                          ],
                        )
                    ),
                    SizedBox(height: 15,)
                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }


}

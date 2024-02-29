
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
import 'package:dyslexia_project/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exam_detail_page.dart';

class ExamItem extends StatefulWidget {

  String examCode;
  int examNumber;

  ExamItem({
    required this.examCode,
    required this.examNumber
});

  @override
  State<ExamItem> createState() => _ExamItemState();
}

class _ExamItemState extends State<ExamItem> {

  bool isDone = false;
  var totalQues = 0;

  Future<void> getListExams() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('examCollection').where('examCode', isEqualTo: widget.examCode).get();

    final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    setState(() {
      totalQues = data != null && data is Map<String, dynamic> ? data['totalQues'] : 0 ;
    });
  }

  // get doneExams list -> check if doneExams list contain doneExam which has examNumber = widget.examNum
  // if yes -> setState(isDone == true) else setSate(isDone == false)

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

    List<dynamic> doneExams = data != null && data is Map<String, dynamic> ? data['doneExams'] : [];

    for (var doneExam in doneExams) {
      if (doneExam['examCode'] == widget.examCode) {
        setState(() {
          isDone = true;
        });
        break;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListExams();
    getDoneExams();
  }


  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        Get.to(ExamDetailPage(examCode: widget.examCode,));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade200,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3), // Shadow position (x, y)
              blurRadius: 5, // Spread of the shadow
              spreadRadius: 2, // Extends the shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 4 : MediaQuery.of(context).size.height / 4,
                height: orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 4 : MediaQuery.of(context).size.height / 4,
                child: Image.asset('assets/images/take_test_1.png', fit: BoxFit.contain,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
              child: Text('Bài kiểm tra số ${widget.examNumber+1}', style: Theme.of(context).textTheme.bodyLarge, overflow: TextOverflow.ellipsis, maxLines: 2,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
              child: Text('Mã bài: ' + (widget.examCode), style: Theme.of(context).textTheme.bodyLarge, overflow: TextOverflow.ellipsis, maxLines: 2,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Text('Số câu: ' + totalQues.toString(), style: Theme.of(context).textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(isDone ? 'Đã làm' : 'Chưa làm', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 20 : MediaQuery.of(context).size.height / 20), textAlign: TextAlign.justify,),
            ),
          ],
        ),
      ),
    );
  }
}

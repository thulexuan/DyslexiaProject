import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/exams/views/component/exam_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exams/views/exam_detail_page.dart';
import 'done_process_detail.dart';

class DoExamProcess extends StatefulWidget {
  DoExamProcess({Key? key, required this.email}) : super(key: key);

  String email;

  @override
  State<DoExamProcess> createState() => _DoExamProcessState();
}

class _DoExamProcessState extends State<DoExamProcess> {

  List<dynamic> doneExams = [];

  Future<void> getDoneExams(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',
        isEqualTo: email) // add your condition here
        .get();

    // get data from the first document in the snapshot
    final Object? data =
    snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    setState(() {
      doneExams = data != null && data is Map<String, dynamic> ? data['doneExams'] : [];
    });

  }

  @override
  void initState() {
    super.initState();
    getDoneExams(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.email);
    return Scaffold(
      appBar: AppBar(title: const Text('Bài kiểm tra đã làm'),),
      body: doneExams.length == 0 ? Text('Chưa làm bài kiểm tra nào') : Column(
        children: [
          for (var doneExam in doneExams)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(ExamDetailPage(examCode: doneExam['examCode'],));
                    },
                    child: const Icon(Icons.launch)
                ),
                Text('Bài kiểm tra mã ${doneExam['examCode']}'),
                TextButton(
                    onPressed: () {
                      Get.to(DoneProcessDetailPage(examCode: doneExam['examCode'], doneProcesses: doneExam['doneProcess'],));
                    },
                    child: const Text('Xem kết quả')
                )
              ],
            )
        ],
      ),
    );
  }
}

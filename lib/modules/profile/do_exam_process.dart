import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/exams/views/component/exam_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exams/views/exam_detail_page.dart';

class DoExamProcess extends StatefulWidget {
  const DoExamProcess({Key? key}) : super(key: key);

  @override
  State<DoExamProcess> createState() => _DoExamProcessState();
}

class _DoExamProcessState extends State<DoExamProcess> {
  int numOfExams  = 0;

  List totalQuesOfEachExam = [];

  Future<void> getListExams() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('examCollection').get();
    setState(() {
      numOfExams = querySnapshot.docs.length;
    });

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      setState(() {
        totalQuesOfEachExam.add(data['totalQues']);
      });

    }
  }

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
    getListExams();
    getDoneExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bài kiểm tra đã làm'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text('Tỷ lệ đúng gần nhất',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(
                itemCount: doneExams.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 35, 15),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      leading: IconButton(
                          onPressed: () {
                            Get.to(ExamDetailPage(examNumber: doneExams[index],));
                          },
                          icon: Icon(Icons.launch))
                      ,
                      title: Text('Bài kiểm tra số ${doneExams[index]+1}', style: TextStyle(fontWeight: FontWeight.bold),),
                      trailing: Text('${(resultDoneExams[index] * 100)}%', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 2.0,); },
              ),
          )
        ],
      ),
    );
  }
}

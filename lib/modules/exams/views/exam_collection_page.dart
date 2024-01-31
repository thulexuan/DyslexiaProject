import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'component/exam_item.dart';

class ExamCollectionPage extends StatefulWidget {
  const ExamCollectionPage({Key? key}) : super(key: key);

  @override
  State<ExamCollectionPage> createState() => _ExamCollectionPageState();
}

class _ExamCollectionPageState extends State<ExamCollectionPage> {

  int numOfExams  = 0;
  List<dynamic> examCodes = [];
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
        examCodes.add(data['examCode']);
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListExams();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Bài kiểm tra'), automaticallyImplyLeading: false,),
      body: GridView.count(
        padding: EdgeInsets.all(20.0),
        crossAxisCount: 2,
        childAspectRatio: 3/5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 30,
        children: List.generate(numOfExams, (index) {
          return ExamItem(examCode: examCodes[index], examNumber: index,);
        }),
      ),
    );
  }
}

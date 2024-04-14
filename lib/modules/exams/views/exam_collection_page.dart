import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'component/exam_item.dart';

class ExamCollectionPage extends StatefulWidget {

  String classLevel;

  ExamCollectionPage({
    required this.classLevel
});

  @override
  State<ExamCollectionPage> createState() => _ExamCollectionPageState();
}

class _ExamCollectionPageState extends State<ExamCollectionPage> {

  int numOfExams  = 0;
  List<dynamic> examCodes = [];
  List totalQuesOfEachExam = [];

  Future<void> getListExams() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('examCollection')
    .where('classLevel', isEqualTo: widget.classLevel).get();
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
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(toolbarHeight: MediaQuery.of(context).size.height / 12,
        title: Text('Bài kiểm tra', style: Theme.of(context).textTheme.labelSmall),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(20.0),
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: 4/5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 30,
        children: List.generate(numOfExams, (index) {
          return ExamItem(examCode: examCodes[index], examNumber: index,);
        }),
      ),
    );
  }
}

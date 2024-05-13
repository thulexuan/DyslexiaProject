import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/common/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/doneExam.dart';
import '../../../models/doneProcess.dart';

class EachExamController extends GetxController {

  var listCorrectAnswer = [].obs;
  var listUserAnswer = [].obs;

  var long_text = ''.obs;
  var listQuestions = [].obs;
  var numOfCorrect = 0.obs;

  var isDone = false.obs;

  Future<void> getExamDetail(String examCode) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('examCollection').where('examCode', isEqualTo: examCode).get();

    // get data from the first document in the snapshot
    final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    long_text.value =  data != null && data is Map<String, dynamic> ? data['text'] : 'no text' ;
    listQuestions.value = data != null && data is Map<String, dynamic> ? data['questions'] : [];

    listUserAnswer.value.clear();
    listUserAnswer.value = List.generate(listQuestions.length, (index) => -1);

    List correctAns = [];

    for (var question in listQuestions) {
      correctAns.add(question['answer']);
    }

    listCorrectAnswer.value = correctAns;

  }

  resultProcess() async {
    numOfCorrect.value = 0;

    for (int i=0;i<listQuestions.length;i++) {
      if (listUserAnswer[i] == listCorrectAnswer[i]) {
        numOfCorrect.value++;
      }
    }

  }

  var doneExams = [].obs;
  Future<void> getDoneExams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',
        isEqualTo: prefs.getString('email')) // add your condition here
        .get();

    // get data from the first document in the snapshot
    final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    doneExams.value = data != null && data is Map<String, dynamic> ? data['doneExams'] : [];

  }

  Future<void> saveDoneExamToDb(String examCode) async {

    await getDoneExams();
    bool isDone = false;

    for (var i=0;i<doneExams.length;i++) {
      // check xem đã làm bài có mã examNumber chưa
      if (doneExams[i]['examCode'] == examCode) {
        isDone = true;
        break;
      }
    }

    // nếu chưa làm lần nào -> tạo một instance doneExam mới -> doneExams.add(doneExam)
    if (isDone == false) {
      List<Map<String, dynamic>> doneProcesses = [];
      DoneProcess doneProcessDetail = DoneProcess(date: DateTime.now(), score: numOfCorrect.value / listQuestions.length);
      Map<String, dynamic> doneProcessDetailMap = doneProcessDetail.toJson();
      doneProcesses.add(doneProcessDetailMap);
      DoneExam doneExam = DoneExam(examCode: examCode, doneProcess: doneProcesses);
      Map<String, dynamic> doneExamMap = doneExam.toJson();
      doneExams.add(doneExamMap);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email',
          isEqualTo: prefs.getString('email')) // add your condition here
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs[0]
            .reference
            .update({
          'doneExams' : doneExams
        });
      }
    } else {
      // nếu đã làm ít nhất một lần rồi -> tìm trong doneExams doneExam có doneExam['examNumber'] == widget.examNumber
      // lấy doneProcess của doneExam đó (doneExam['doneProcess']) -> add thêm phần tử vào doneProcess -> update lại field doneExams
      for (var doneExam in doneExams) {
        if (doneExam['examCode'] == examCode) {
          List<dynamic> doneProcesses = doneExam['doneProcess'];
          DoneProcess doneProcessDetail = DoneProcess(date: DateTime.now(), score: numOfCorrect.value / listQuestions.length);
          Map<String, dynamic> doneProcessDetailMap = doneProcessDetail.toJson();
          doneProcesses.add(doneProcessDetailMap);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          final QuerySnapshot snapshot = await FirebaseFirestore.instance
              .collection('users').where('email', isEqualTo: prefs.getString('email')).get();

          if (snapshot.docs.isNotEmpty) {
            await snapshot.docs[0]
                .reference
                .update({
              'doneExams' : doneExams
            });
          }
        }
      }
    }
  }
}
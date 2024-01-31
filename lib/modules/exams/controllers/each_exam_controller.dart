import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/common/controllers/user_controller.dart';
import 'package:get/get.dart';

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
}
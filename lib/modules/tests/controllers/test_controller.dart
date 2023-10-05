

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/models/customizeTextQuestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  var selectedOption = [].obs;
  var currentQuestionIndex = 0.obs;

  var questions = <CustomizeTextQuestion>[].obs;

  PageController pageController = PageController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController();
    getData();
  }

  Future<void> getData() async {
    QuerySnapshot questionData =
    await FirebaseFirestore.instance.collection('testCustomizeText').get();
    questions.clear();

    // for (var question in questionData.docs) {
    //
    //
    //   questions.add(
    //       CustomizeTextQuestion(
    //           id: question['id'],
    //           question: question['question'],
    //           content: question['content'],
    //           options: (question["options"] as List<dynamic>).map((e) =>
    //               CustomizeTextOption.fromJson(e)).toList(),
    //           selectedOption: question['selectedOption'])
    //   );
    // }
    questions.value = questionData.docs
        .map((m) => CustomizeTextQuestion.fromJson(m.data() as Map<String, dynamic>))
        .toList();
    print("okela");
    print(questions.value.length);
    for (int i=0;i<questions.value.length;i++) {
      selectedOption.value.add(10);
    }
  }

  void updateSelectedOption(int questionIndex, int index) {
    selectedOption.value[questionIndex] = index;
  }

  void chooseOption(int questionIndex, int selectedOption) {
    print(questionIndex);
    print(selectedOption);
    // update field selectedOption here
  }

  void updateQuestionIndex(int index) {
    currentQuestionIndex.value = index;
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
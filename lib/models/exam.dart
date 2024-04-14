import 'package:dyslexia_project/models/question.dart';

class Exam {
  // int examNumber;
  String examCode;
  List<Map<String, dynamic>> questions;
  String text;
  int totalQues;
  String authorName;
  String classLevel;

  Exam({
    // required this.examNumber,
    required this.examCode,
    required this.questions,
    required this.text,
    required this.totalQues,
    required this.authorName,
    required this.classLevel
});

  Map<String, dynamic> toJson() => {
    // "examNumber" : examNumber,
    "examCode" : examCode,
    "questions" : questions,
    "text" : text,
    "totalQues" : totalQues,
    "authorName" : authorName,
    "classLevel" : classLevel
  };

  static Exam fromJson(Map<String, dynamic> json) => Exam(
      // examNumber: json['examNumber'],
      examCode: json['examCode'],
      questions: json['questions'],
      text: json['text'],
      totalQues: json['totalQues'],
      authorName: json['authorName'],
      classLevel: json['classLevel']
  );
}
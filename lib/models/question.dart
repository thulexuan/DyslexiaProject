class Question {
  int answer;
  List<String> options;
  String questionDetail;

  Question({
    required this.answer,
    required this.options,
    required this.questionDetail
});

  Map<String, dynamic> toJson() => {
    "answer" : answer,
    "options" : options,
    "questionDetail" : questionDetail,
  };

  static Question fromJson(Map<String, dynamic> json) => Question(
      answer: json['answer'],
      options: json['options'],
      questionDetail: json['questionDetail'],
  );
}
class Question {
  int answer;
  List<String> options;
  String questionDetail;
  String suggestedPara;
  String keySentence;

  Question({
    required this.answer,
    required this.options,
    required this.questionDetail,
    required this.suggestedPara,
    required this.keySentence
});

  Map<String, dynamic> toJson() => {
    "answer" : answer,
    "options" : options,
    "questionDetail" : questionDetail,
    "suggestedPara" : suggestedPara,
    "keySentence" : keySentence
  };

  static Question fromJson(Map<String, dynamic> json) => Question(
      answer: json['answer'],
      options: json['options'],
      questionDetail: json['questionDetail'],
      suggestedPara: json['suggestedPara'],
      keySentence: json['keySentence'],
  );
}
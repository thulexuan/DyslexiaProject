class DoneProcess {
  DateTime date;
  double score;

  DoneProcess({
    required this.date,
    required this.score
});

  Map<String, dynamic> toJson() => {
    "date" : date,
    "score" : score,
  };

  static DoneProcess fromJson(Map<String, dynamic> json) => DoneProcess(
    date: json['date'],
    score: json['score'],
  );

}
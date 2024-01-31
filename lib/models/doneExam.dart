class DoneExam {
  String examCode;
  List<Map<String, dynamic>> doneProcess;

  DoneExam({
    required this.examCode,
    required this.doneProcess
});

  Map<String, dynamic> toJson() => {
    "examCode" : examCode,
    "doneProcess" : doneProcess,
  };

  static DoneExam fromJson(Map<String, dynamic> json) => DoneExam(
      examCode: json['examCode'],
      doneProcess: json['doneProcess'],
  );
}
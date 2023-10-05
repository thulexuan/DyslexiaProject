
import 'customizeTextOption.dart';

class CustomizeTextQuestion {
  int? id;
  int? selectedOption;
  String? question;
  String? content;
  List<CustomizeTextOption>? options;

  CustomizeTextQuestion({
    required this.id,
    required this.question,
    required this.content,
    required this.options,
    required this.selectedOption
});

  // CustomizeTextQuestion.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   content = json['content'];
  //   question = json['question'];
  //   selectedOption = json['selectedOption'];
  //   if (json['options'] != null) {
  //     options = <CustomizeTextOption>[];
  //     json['options'].forEach((v) {
  //       options!.add(new CustomizeTextOption.fromJson(v));
  //     });
  //   }
  // }

  static CustomizeTextQuestion fromJson(Map<String, dynamic> json) => CustomizeTextQuestion(
    id: json["id"],
    question: json["question"],
    content: json["content"],
    selectedOption: json["selectedOption"],
    options: (json["options"] as List<dynamic>).map((e) =>
        CustomizeTextOption.fromJson(e)).toList(),
  );


}
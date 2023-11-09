import 'package:flutter/material.dart';

class QuestionOption extends StatelessWidget {

  bool isSelected = false;
  String content;

  QuestionOption({
    required this.isSelected,
    required this.content
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(isSelected == true ? Icons.radio_button_checked : Icons.radio_button_off),
              SizedBox(width: 8,),
              Text(content)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ReviewEachQuestion extends StatelessWidget {

  String userAnswer;
  String correctAnswer;
  int questionNum;

  ReviewEachQuestion({
    required this.userAnswer,
    required this.correctAnswer,
    required this.questionNum
});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Câu ${questionNum+1} : ',
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                  TextSpan(
                    text: (userAnswer == correctAnswer ? 'Đúng' : 'Sai'),
                    style: TextStyle(fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 20 : MediaQuery.of(context).size.height / 20, fontWeight: FontWeight.bold, color: userAnswer == correctAnswer ? Colors.green : Colors.red)
                  )
                ]
              )
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text('Đáp án bạn chọn : ' + userAnswer, style: Theme.of(context).textTheme.bodyMedium,),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text('Đáp án đúng : ' + correctAnswer, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Divider(thickness: 2,),
        ],
      ),
    );
  }
}

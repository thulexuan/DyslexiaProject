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
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold, color: userAnswer == correctAnswer ? Colors.green : Colors.red)
                  )
                ]
              )
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text('Đáp án bạn chọn : ' + userAnswer),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text('Đáp án đúng : ' + correctAnswer),
          ),
          Divider(thickness: 2,),
        ],
      ),
    );
  }
}

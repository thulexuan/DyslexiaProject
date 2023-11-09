import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class QuestionItem extends StatelessWidget {

  String question;

  QuestionItem({
    required this.question
});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // loa phát yêu cầu
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/pointing.gif', width: 60, height: 60,),
                IconButton(
                    onPressed: () {
                      SoundFunction().speak(question, 0.5, 0.5, 0.8, 'vi-vn-x-gft-network');
                    },
                    icon: const Icon(Icons.volume_up, size: 50, color: Colors.white,)
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.question_mark, size: 35, color: Colors.white,),
                Flexible(
                    child: Text(question, style: TextStyle(fontSize: 20, color: Colors.white),)
                )
              ],
            )

          ]
      ),
    );
  }
}

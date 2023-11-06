import 'package:flutter/material.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({Key? key}) : super(key: key);

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
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.volume_up, size: 40, color: Colors.white,)
            ),
            const SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.question_mark, size: 35, color: Colors.white,),
                Flexible(
                    child: Text('Hãy chọn chữ bạn cho là dễ nhìn nhất', style: TextStyle(fontSize: 20, color: Colors.white),)
                )
              ],
            )

          ]
      ),
    );
  }
}

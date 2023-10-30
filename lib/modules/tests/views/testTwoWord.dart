import 'package:flutter/material.dart';

import '../../../common_widgets/test_element.dart';
import '../../../models/testElement.dart';

class TestTwoWordPage extends StatefulWidget {

  @override
  State<TestTwoWordPage> createState() => _TestTwoWordPageState();

  String word;

  TestTwoWordPage({
    required this.word
  });
}

class _TestTwoWordPageState extends State<TestTwoWordPage> {
  @override
  Widget build(BuildContext context) {

    List<TestElement> words  = [
      TestElement(word: widget.word, fontSize: 24, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 24, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Arial', letterSpacing: 0, wordSpacing: 21, isSelected: false,),
      TestElement(word: widget.word, fontSize: 35, fontFamily: 'Times New Roman', letterSpacing: 0, wordSpacing: 21, isSelected: false,),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Test Two Word Page'),),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 800,
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.volume_up)
            ),
            SizedBox(height: 20,),
            Text('Hãy chọn chữ bạn cho là dễ nhìn nhất'),
            SizedBox(height: 60,),
            Expanded(
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          child: Text(words[0].word, style: TextStyle(fontSize: words[0].fontSize, fontFamily: words[0].fontFamily, letterSpacing: words[0].letterSpacing, wordSpacing: words[0].wordSpacing),)
                      ),
                      Container(
                          child: Text(words[1].word, style: TextStyle(fontSize: words[1].fontSize, fontFamily: words[1].fontFamily, letterSpacing: words[1].letterSpacing, wordSpacing: words[1].wordSpacing),)),
                      Container(
                          child: Text(words[2].word, style: TextStyle(fontSize: words[2].fontSize, fontFamily: words[2].fontFamily, letterSpacing: words[2].letterSpacing, wordSpacing: words[2].wordSpacing),)
                      ),
                      Container(
                          child: Text(words[3].word, style: TextStyle(fontSize: words[3].fontSize, fontFamily: words[3].fontFamily, letterSpacing: words[3].letterSpacing, wordSpacing: words[3].wordSpacing),)
                      ),
                      Container(
                          child: Text(words[4].word, style: TextStyle(fontSize: words[4].fontSize, fontFamily: words[4].fontFamily, letterSpacing: words[4].letterSpacing, wordSpacing: words[4].wordSpacing),)
                      ),
                      Container(
                          child: Text(words[5].word, style: TextStyle(fontSize: words[5].fontSize, fontFamily: words[5].fontFamily, letterSpacing: words[5].letterSpacing, wordSpacing: words[5].wordSpacing),)
                      ),
                    ],
                  ),
            ),
            SizedBox(height: 150,)
          ],
        ),
      ),
    );
  }
}

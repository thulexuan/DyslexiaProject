import 'package:dyslexia_project/common_widgets/test_element.dart';
import 'package:flutter/material.dart';

import '../../../models/testElement.dart';

class TestSentencePage extends StatefulWidget {

  @override
  State<TestSentencePage> createState() => _TestSentencePageState();

  String sentence = "câu này không có nghĩa";
  String fontFamily;

  TestSentencePage({
     required this.fontFamily
});
}

class _TestSentencePageState extends State<TestSentencePage> {
  @override
  Widget build(BuildContext context) {

    List<TestElement> sentences  = [
      TestElement(word: widget.sentence, fontSize: 24, fontFamily: widget.fontFamily, letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 30, fontFamily: widget.fontFamily, letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 35, fontFamily: widget.fontFamily, letterSpacing: 0, wordSpacing: 0, isSelected: false,),
      TestElement(word: widget.sentence, fontSize: 35, fontFamily: widget.fontFamily, letterSpacing: 0, wordSpacing: 0, isSelected: false,),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Test Sentence Page'),),
      body: Container(
        child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 800,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.volume_up, size: 40,)
                ),
                SizedBox(height: 30,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                            child: Text(widget.sentence, style: TextStyle(fontSize: sentences[0].fontSize, fontFamily: widget.fontFamily, letterSpacing: sentences[0].letterSpacing, wordSpacing: sentences[0].wordSpacing),)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                            child: Text(widget.sentence, style: TextStyle(fontSize: sentences[1].fontSize, fontFamily: widget.fontFamily, letterSpacing: sentences[1].letterSpacing, wordSpacing: sentences[1].wordSpacing),)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(widget.sentence, style: TextStyle(fontSize: sentences[2].fontSize, fontFamily: widget.fontFamily, letterSpacing: sentences[2].letterSpacing, wordSpacing: sentences[2].wordSpacing),)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(widget.sentence, style: TextStyle(fontSize: sentences[3].fontSize, fontFamily: widget.fontFamily, letterSpacing: sentences[3].letterSpacing, wordSpacing: sentences[3].wordSpacing, color: Colors.black.withOpacity(0.5)),)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 200,)
              ],
            ),
      )
    );
  }
}

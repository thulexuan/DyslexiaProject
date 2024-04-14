import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../customizeText/controllers/text_customize_controller.dart';

class ReadEachSentencePage extends StatefulWidget {

  String content;
  TextCustomizeController textCustomizeController;
  List<dynamic> errorWords;

  ReadEachSentencePage({
    required this.content,
    required this.textCustomizeController,
    required this.errorWords
});
  @override
  State<ReadEachSentencePage> createState() => _ReadEachSentencePageState();
}

class _ReadEachSentencePageState extends State<ReadEachSentencePage> {
  
  List<String> letterList = [];
  List<String> wordList = [];

  List<bool> letterListIsBolded = [];
  List<List<bool>> isBolded = [];

  void createWordList() {
    setState(() {
      wordList = widget.content.split(' ');
    });
  }

  void createLetterList() {

    for (int i = 0; i < wordList.length; i++) {
      List<bool> temp = [];
      for (int j = 0; j < wordList[i].length; j++) {
        temp.add(false);
      }
      setState(() {
        isBolded.add(temp);
      });
    }
  }

  Map<String, Color> mapping = {
    'b' : Colors.blue,
    'd' : Colors.red,
    'p' : Colors.green,
    'q' : Colors.pink,
    'm' : Colors.orange,
    'n' : Colors.teal,
    'u' : Colors.blue
  };


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createWordList();
    createLetterList();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.textCustomizeController.backgroundColor.elementAt(widget.textCustomizeController.backgroundColor_text.indexOf(widget.textCustomizeController.currentBackgroundColor.value)),
      appBar: AppBar(title: Text('Đọc câu', style: Theme.of(context).textTheme.labelSmall,),
      toolbarHeight: MediaQuery.of(context).size.height / 12,),
      body: Obx(() => Center(
        child: SelectableText.rich(
            TextSpan(
                children: <TextSpan> [
                  for (int i = 0; i < wordList.length; i++)
                    TextSpan(
                      children: <TextSpan> [
                        for (int j = 0; j < wordList[i].length; j++) // for each letter
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isBolded[i][j] = !isBolded[i][j];
                                    // isErrorWord[i][j] = !isErrorWord[i][j];
                                  });
                                },
                              text: wordList[i][j],
                              style: isBolded[i][j] ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: widget.textCustomizeController.currentFontSize.value.toDouble(),
                                  fontFamily: widget.textCustomizeController.currentFontStyle.value,
                                  letterSpacing: widget.textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                  wordSpacing: widget.textCustomizeController.currentWordSpacing.value.toDouble(),
                                  height: widget.textCustomizeController.currentLineSpacing.value.toDouble()
                              )
                                  : (widget.errorWords.contains(wordList[i][j]) ? TextStyle(
                                  color: mapping[wordList[i][j]],
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.textCustomizeController.currentFontSize.value.toDouble() + 1,
                                  fontFamily: widget.textCustomizeController.currentFontStyle.value,
                                  letterSpacing: widget.textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                  wordSpacing: widget.textCustomizeController.currentWordSpacing.value.toDouble(),
                                  height: widget.textCustomizeController.currentLineSpacing.value.toDouble()

                              ): TextStyle(
                                  color: widget.textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(widget.textCustomizeController.currentOpacity.value)
                                      : widget.textCustomizeController.textColor.elementAt(widget.textCustomizeController.textColor_text.indexOf(widget.textCustomizeController.currentTextColor.value)),
                                  fontWeight: FontWeight.normal,
                                  fontSize: widget.textCustomizeController.currentFontSize.value.toDouble() + 1,
                                  fontFamily: widget.textCustomizeController.currentFontStyle.value,
                                  letterSpacing: widget.textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                  wordSpacing: widget.textCustomizeController.currentWordSpacing.value.toDouble(),
                                  height: widget.textCustomizeController.currentLineSpacing.value.toDouble()

                              )
                              )
                          ),


                        TextSpan(
                            text: ' ',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: widget.textCustomizeController.currentFontSize.value.toDouble(),
                                fontFamily: widget.textCustomizeController.currentFontStyle.value,
                                letterSpacing: widget.textCustomizeController.currentWordSpacing.value.toDouble(),
                                height: widget.textCustomizeController.currentLineSpacing.value.toDouble()
                            )
                        )
                      ],

                    ),

                ]
            )
        ),
      ),
      )
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/controllers/sound.dart';
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
  // List<List<bool>> isBolded = [];
  List<bool> isBolded = [];

  void createWordList() {
    setState(() {
      wordList = widget.content.split(' ');
    });
  }

  // void createLetterList() {
  //
  //   for (int i = 0; i < wordList.length; i++) {
  //     List<bool> temp = [];
  //     for (int j = 0; j < wordList[i].length; j++) {
  //       temp.add(false);
  //     }
  //     setState(() {
  //       isBolded.add(temp);
  //     });
  //   }
  // }

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
    // createLetterList();
    for (int i = 0; i < wordList.length; i++) {
      setState(() {
        isBolded.add(false);
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.textCustomizeController.backgroundColor.elementAt(widget.textCustomizeController.backgroundColor_text.indexOf(widget.textCustomizeController.currentBackgroundColor.value)),
      appBar: AppBar(title: Text('Đọc câu', style: Theme.of(context).textTheme.labelSmall,),
      toolbarHeight: MediaQuery.of(context).size.height / 12,),
      body: Obx(() => Center(
        child: SelectableText.rich(
            onSelectionChanged: (TextSelection selection, _) {
              String selected_text = widget.content.substring(selection.baseOffset, selection.extentOffset);
              SoundFunction().speakFast(
                  selected_text,
                  widget.textCustomizeController.current_volume.value,
                  widget.textCustomizeController.current_rate.value - 0.1,
                  widget.textCustomizeController.current_pitch.value,
                  widget.textCustomizeController.current_voice_name.value,
                  selected_text.split(' '),
                  0);
            },
            contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
              final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;

              buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                return buttonItem.type == ContextMenuButtonType.cut;
              });
              buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                return buttonItem.type == ContextMenuButtonType.copy;
              });
              buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                return buttonItem.type == ContextMenuButtonType.selectAll;
              });
              buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                return buttonItem.type == ContextMenuButtonType.paste;
              });

              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: buttonItems,
              );
            },
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
                                    isBolded[i] = !isBolded[i];
                                    // isErrorWord[i][j] = !isErrorWord[i][j];
                                  });
                                },
                              text: wordList[i][j],
                              style: isBolded[i] ? TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: widget.textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(widget.textCustomizeController.currentOpacity.value)
                                      : widget.textCustomizeController.textColor.elementAt(widget.textCustomizeController.textColor_text.indexOf(widget.textCustomizeController.currentTextColor.value)),
                                  fontWeight: FontWeight.w900,
                                  color: widget.textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(widget.textCustomizeController.currentOpacity.value)
                                      : widget.textCustomizeController.textColor.elementAt(widget.textCustomizeController.textColor_text.indexOf(widget.textCustomizeController.currentTextColor.value)),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SoundFunction().speakFast(
              widget.content,
              widget.textCustomizeController.current_volume.value,
              widget.textCustomizeController.current_rate.value - 0.1,
              widget.textCustomizeController.current_pitch.value,
              widget.textCustomizeController.current_voice_name.value,
              widget.content.split(' '),
              0);
        },
        child: Icon(Icons.volume_up),
      ),
    );
  }
}

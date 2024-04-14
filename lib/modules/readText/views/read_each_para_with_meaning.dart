import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/word_image_mapping.dart';
import '../../common/controllers/sound.dart';
import '../../customizeText/controllers/text_customize_controller.dart';

class ReadEachParagraphWithMeaning extends StatefulWidget {
  String paragraph;
  List<String> words;

  ReadEachParagraphWithMeaning({
    required this.paragraph,
    required this.words
  });

  @override
  State<ReadEachParagraphWithMeaning> createState() => _ReadEachParagraphWithMeaningState();
}

class _ReadEachParagraphWithMeaningState extends State<ReadEachParagraphWithMeaning> {

  final TextCustomizeController textCustomizeController = Get.put(TextCustomizeController());

  List<String> wordsUsed = [];
  List<bool> isBold = [];

  late int start_position;
  late int end_position;
  late String selected_text;

  void processText() {
    for (int i = 0; i < widget.words.length; i++) {
      setState(() {
        wordsUsed.add(widget.words[i]);
        wordsUsed.add(' ');
      });
    }

    for (int i = 0; i < wordsUsed.length; i++) {
      setState(() {
        isBold.add(false);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textCustomizeController.getData();
    processText();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đọc đoạn', style: Theme.of(context).textTheme.labelSmall,),
      toolbarHeight: MediaQuery.of(context).size.height / 12,),
      body: Stack(
          children: [
            Container(
              color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
              child: Center(
                  child: SingleChildScrollView(
                    child: Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                      child: SelectableText.rich(

                        // style: TextStyle(
                        //     color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                        //     fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                        //     fontFamily: textCustomizeController.currentFontStyle.value,
                        //     letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                        //     wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                        //     height: textCustomizeController.currentLineSpacing.value.toDouble()
                        // ),
                        // TextSpan(
                        //   children: <InlineSpan> [
                        //     for (int j = 0; j < wordsUsed.length; j++)
                        //       WidgetSpan(
                        //           child: GestureDetector(
                        //             // onTap: () {
                        //             //   setState(() {
                        //             //     isBold[j] = !isBold[j];
                        //             //   });
                        //             // },
                        //             onPanUpdate: (details) {
                        //               print('aihi');
                        //             },
                        //             child: Text(wordsUsed[j],
                        //               style: wordsUsed[j] == ' ' ? TextStyle(
                        //                   color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                        //                   fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                        //                   fontFamily: textCustomizeController.currentFontStyle.value,
                        //                   letterSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                        //                   height: textCustomizeController.currentLineSpacing.value.toDouble()
                        //               ) :
                        //               (isBold[j] ? TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                        //                   fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                        //                   fontFamily: textCustomizeController.currentFontStyle.value,
                        //                   letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                        //                   height: textCustomizeController.currentLineSpacing.value.toDouble()
                        //               ) : TextStyle(
                        //                   fontWeight: FontWeight.normal,
                        //                   color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                        //                   fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                        //                   fontFamily: textCustomizeController.currentFontStyle.value,
                        //                   letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                        //                   height: textCustomizeController.currentLineSpacing.value.toDouble()
                        //               ))
                        //             )
                        //           )
                        //       )
                        //   ]
                        // ),
                        TextSpan(
                            children: <TextSpan> [
                              for (int j = 0; j < wordsUsed.length; j++)
                                TextSpan(

                                  text: wordsUsed[j],
                                  style: wordsUsed[j] == ' ' ? TextStyle(
                                      color: textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(textCustomizeController.currentOpacity.value)
                                          : textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                                      fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                      fontFamily: textCustomizeController.currentFontStyle.value,
                                      letterSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                      // wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                      height: textCustomizeController.currentLineSpacing.value.toDouble()
                                  )
                                      : TextStyle(
                                      color: textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(textCustomizeController.currentOpacity.value)
                                          : textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                                      fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                      fontFamily: textCustomizeController.currentFontStyle.value,
                                      letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                      // wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                      height: textCustomizeController.currentLineSpacing.value.toDouble()
                                  ),
                                )
                            ]
                        ),
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
                        onSelectionChanged: (TextSelection selection, _) {
                          setState(() {
                            start_position = selection.baseOffset;
                            end_position = selection.extentOffset;
                            selected_text = widget.paragraph.substring(start_position, end_position);
                          });
                          print(selected_text);
                        },
                      ),
                    ),
                    ),
                  )
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 150,
              left: MediaQuery.of(context).size.width  - 220,
              child: Row(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      showImage(selected_text);
                    },
                    child: Icon(Icons.image),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () {
                      speakWord(selected_text);
                    },
                    child: Icon(Icons.headphones),
                  ),
                ],
              ),
            )
          ]
      ),
    );
  }

  Future<void> showImage(String text) async {
    String? imageUrl;
    if (wordImageMapping.containsKey(text)) {
      imageUrl = wordImageMapping["${text}"];
    }
    _showDialog(
        context, imageUrl, text
    );
  }

  void _showDialog(BuildContext context, String? imageUrl, String word) {
    Navigator.of(context).push(
      DialogRoute<void>(
          context: context,
          builder: (BuildContext context) =>
              Dialog(
                  child: Container(
                    height: 600,
                    width: 600,
                    child: Column(
                      children: [
                        Container(
                            width: 400,
                            height: 400,
                            child: imageUrl != null ? Image.asset(imageUrl!) : Image.asset('assets/images/no_image.png')
                        ),
                        Text(word, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
                        SizedBox(height: 20,),
                        IconButton(
                          onPressed: () {
                            SoundFunction().speakFast(
                                word,
                                textCustomizeController.current_volume.value,
                                textCustomizeController.current_rate.value,
                                textCustomizeController.current_pitch.value,
                                textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
                                word.split(' '),
                                0
                            );
                          },
                          icon: Icon(Icons.volume_up, size: Theme.of(context).iconTheme.size,),
                        )
                      ],
                    ),
                  )
              )
      ),
    );
  }

  Future<void> speakWord(String text) async {
    SoundFunction().speakFast(
        text,
        textCustomizeController.current_volume.value,
        textCustomizeController.current_rate.value,
        textCustomizeController.current_pitch.value,
        textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
        text.split(' '),
        0
    );
  }

}

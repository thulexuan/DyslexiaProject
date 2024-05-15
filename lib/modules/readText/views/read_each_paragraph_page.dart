import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/readText/views/read_each_sentence_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/word_image_mapping.dart';
import '../../common/controllers/sound.dart';
import '../../customizeText/controllers/text_customize_controller.dart';
import '../../customizeText/views/customize_option_page.dart';

class ReadEachParagraphPage extends StatefulWidget {

  String paragraph;
  List<String> wordsList;
  List<dynamic> errorWords;

  ReadEachParagraphPage({
    required this.paragraph,
    required this.wordsList,
    required this.errorWords
});

  @override
  State<ReadEachParagraphPage> createState() => _ReadEachParagraphPageState();
}

class _ReadEachParagraphPageState extends State<ReadEachParagraphPage> {

  final TextCustomizeController textCustomizeController = Get.put(TextCustomizeController());
  FlutterTts tts = FlutterTts();


  List<String> wordsUsed = [];
  List<bool> isBold = [];

  List<String> sentencesByPoem = [];
  List<String> sentenceByPara = [];

  int startPos = 0;
  int endPos = 0;
  String selectedText  = '';
  
  bool isExplainingMeaning = false;

  void processText() {

    for (int i = 0; i < widget.wordsList.length; i++) {
      setState(() {
        wordsUsed.add(widget.wordsList[i]);
        wordsUsed.add(' ');
      });
    }

    for (int i = 0; i < wordsUsed.length; i++) {
      setState(() {
        isBold.add(false);
      });
    }
  }

  void createSentenceListByPoem() {
    List<String> sentenceList = widget.paragraph.split('\n');
    for (int i = 0; i < sentenceList.length; i ++) {
      if (sentenceList[i].length > 1) {
        sentencesByPoem.add(sentenceList[i]);
      }
    }
  }

  void createSentenceListByPara() {
    List<String> miniParaList = widget.paragraph.split('\n');
    for (int i = 0; i < miniParaList.length; i ++) {
      if (miniParaList[i].length > 1) {
        List<String> sentenceList = miniParaList[i].split('.');
        for (int j = 0; j < sentenceList.length; j++) {
          sentenceByPara.add(sentenceList[j]);
        }
      }
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
    textCustomizeController.getData();
    processText();
    createSentenceListByPoem();
    createSentenceListByPara();
    getAllWordImageMapping();
    tts.setLanguage('vi-VN');
    tts.setPitch(0.8);
    tts.setSpeechRate(0.5);
    print(wordsUsed.length);
    print(wordsUsed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đọc đoạn', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const CustomizeOptionPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.tune, color: Colors.blue,),
                        SizedBox(width: 20,),
                        Text('Tùy chỉnh', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  )
              ),
            ];
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 140,
            color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
            child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),

                    child: SelectableText.rich(
                      onSelectionChanged: (TextSelection selection, _) {
                        String selected_text = widget.paragraph.substring(selection.baseOffset, selection.extentOffset);
                        if (!isExplainingMeaning) {
                          tts.speak(selected_text);
                        } else {
                          setState(() {
                            selectedText = selected_text;
                          });
                        }
                      },
                      TextSpan(
                          children: <InlineSpan> [
                            for (int j = 0; j < wordsUsed.length; j++)

                              TextSpan(
                                  // recognizer: !isExplainingMeaning ? (TapGestureRecognizer()..onTap = () {
                                  //   setState(() {
                                  //     isBold[j] = !isBold[j];
                                  //   });
                                  //   print(isBold[j]);
                                  // }) : null,
                                  // text: wordsUsed[j],
                                  children: <InlineSpan> [
                                    for (int k = 0; k < wordsUsed[j].length; k++)
                                      TextSpan(
                                        recognizer: !isExplainingMeaning ? (TapGestureRecognizer()..onTap = () {
                                          setState(() {
                                            isBold[j] = !isBold[j];
                                          });
                                        }) : null,
                                        text: wordsUsed[j][k],
                                        style: isBold[j] ? TextStyle(
                                            color: widget.errorWords.contains(wordsUsed[j][k]) ? mapping[wordsUsed[j][k]] :
                                            textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(textCustomizeController.currentOpacity.value)
                                                : textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                                            fontWeight: FontWeight.bold,
                                            fontSize: textCustomizeController.currentFontSize.value.toDouble() + 1,
                                            fontFamily: textCustomizeController.currentFontStyle.value,
                                            letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                            wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                            height: textCustomizeController.currentLineSpacing.value.toDouble()
                                        )
                                            :
                                        (widget.errorWords.contains(wordsUsed[j][k]) ? TextStyle(color: mapping[wordsUsed[j][k]], fontWeight: FontWeight.w900)
                                            : TextStyle(color: textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(textCustomizeController.currentOpacity.value)
                                            : textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),)),
                                      )
                                  ],

                                  style: wordsUsed[j] == ' ' ?
                                  TextStyle(
                                      color: Colors.red,
                                      fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                      fontFamily: textCustomizeController.currentFontStyle.value,
                                      letterSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                      height: textCustomizeController.currentLineSpacing.value.toDouble()
                                  )
                                      : (isBold[j] ? TextStyle(
                                      // color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: textCustomizeController.currentFontSize.value.toDouble() + 1,
                                      fontFamily: textCustomizeController.currentFontStyle.value,
                                      letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                      wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                      height: textCustomizeController.currentLineSpacing.value.toDouble()
                                  )
                                      : TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(textCustomizeController.currentOpacity.value)
                                          : textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                                      fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                      fontFamily: textCustomizeController.currentFontStyle.value,
                                      letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                      wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                      height: textCustomizeController.currentLineSpacing.value.toDouble()
                                  )
                                  )
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

                              isExplainingMeaning ? buttonItems.insert(0,
                                ContextMenuButtonItem(
                                  label: 'Ảnh',
                                  onPressed: () async {
                                    showImage(selectedText);
                                  },
                                ),
                              ) : null;
                        return AdaptiveTextSelectionToolbar.buttonItems(
                          anchors: editableTextState.contextMenuAnchors,
                          buttonItems: buttonItems,
                        );
                      },

                    ),
                  ),

                )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  SoundFunction().speakFast(
                      widget.paragraph,
                      textCustomizeController.current_volume.value,
                      textCustomizeController.current_rate.value - 0.1,
                      textCustomizeController.current_pitch.value,
                      textCustomizeController.current_voice_name.value,
                      widget.paragraph.split(' '),
                      0);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('Nghe'),
                    SizedBox(width: 8,),
                    Icon(Icons.volume_up, size: 30,)
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < wordsUsed.length; i++) {
                    setState(() {
                      isBold[i] = false;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('Highlight'),
                    SizedBox(width: 8,),
                    Icon(Icons.refresh, size: 30,),
                  ],
                ),
              ),

              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Set the border radius
                      side: BorderSide(color: isExplainingMeaning ? Colors.green : Colors.blue), // Set the border color
                    ),
                  ),
                  backgroundColor: isExplainingMeaning ? MaterialStateProperty.all<Color>(Colors.green) : MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    isExplainingMeaning = !isExplainingMeaning;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('Giải nghĩa'),
                    SizedBox(width: 8,),
                    Icon(Icons.image, size: 30,),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200, // Set the height of the menu
                        child: ListView(
                          children: <Widget>[
                            for (int j = 0; j < sentencesByPoem.length; j++)
                              Column(
                                children: [
                                  ListTile(
                                    title: Text(sentencesByPoem[j]),
                                    onTap: () {
                                      Get.to(ReadEachSentencePage(content: sentencesByPoem[j], textCustomizeController: textCustomizeController, errorWords: widget.errorWords,));
                                    },
                                  ),
                                  Divider(thickness: 2,),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: const [
                    Text('Đọc câu thơ'),
                    SizedBox(width: 8,),
                    Icon(Icons.read_more, size: 30,)
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200, // Set the height of the menu
                        child: ListView(
                          children: <Widget>[
                            for (int j = 0; j < sentenceByPara.length; j++)
                              Column(
                                children: [
                                  ListTile(
                                    title: Text(sentenceByPara[j]),
                                    onTap: () {
                                      Get.to(ReadEachSentencePage(content: sentenceByPara[j], textCustomizeController: textCustomizeController, errorWords: widget.errorWords,));
                                    },
                                  ),
                                  Divider(thickness: 2,),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: const [
                    Text('Đọc câu văn'),
                    SizedBox(width: 8,),
                    Icon(Icons.read_more, size: 30,)
                  ],
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }

  Map<dynamic, List<dynamic>> allWordsImageMapping = {};

  Future<void> getAllWordImageMapping() async {
    // get all users that are students
    QuerySnapshot allPairs = await FirebaseFirestore.instance.collection('imageToExplainCollection').get(); // get all users
    for (var pair in allPairs.docs) {// for từng pair
      for (var word in pair['mappingWords']) {
        if (allWordsImageMapping.containsKey(word)) {
          setState(() {
            allWordsImageMapping[word]!.addAll(pair['imageUrl']);
          });
        } else {
          setState(() {
            allWordsImageMapping[word] = pair['imageUrl'];
          });
        }
      }
    }
  }

  Future<void> showImage(dynamic text) async {

    List<dynamic>? imageUrlList;
    if (allWordsImageMapping.containsKey(text)) {
      imageUrlList = allWordsImageMapping[text];
    }

    _showDialog(
        context, imageUrlList, text
    );
  }

  void _showDialog(BuildContext context, List<dynamic>? imageUrlList, dynamic word) {
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
                            child: PageView.builder(
                                  itemCount: imageUrlList == null ? 1 : imageUrlList.length,
                                itemBuilder: (context, index) {
                                  return imageUrlList == null ? Image.asset("assets/images/no_image.png") : Image.network(imageUrlList[index]);
                                }
                            ),
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

  // Future<void> showImage(String text) async {
  //   String? imageUrl;
  //   if (wordImageMapping.containsKey(text)) {
  //     imageUrl = wordImageMapping["${text}"];
  //   }
  //   _showDialog(
  //       context, imageUrl, text
  //   );
  // }
  //
  // void _showDialog(BuildContext context, String? imageUrl, String word) {
  //   Navigator.of(context).push(
  //     DialogRoute<void>(
  //         context: context,
  //         builder: (BuildContext context) =>
  //             Dialog(
  //                 child: Container(
  //                   height: 600,
  //                   width: 600,
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                           width: 400,
  //                           height: 400,
  //                           child: imageUrl != null ? Image.asset(imageUrl!) : Image.asset('assets/images/no_image.png')
  //                       ),
  //                       Text(word, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
  //                       SizedBox(height: 20,),
  //                       IconButton(
  //                         onPressed: () {
  //                           SoundFunction().speakFast(
  //                               word,
  //                               textCustomizeController.current_volume.value,
  //                               textCustomizeController.current_rate.value,
  //                               textCustomizeController.current_pitch.value,
  //                               textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
  //                               word.split(' '),
  //                               0
  //                           );
  //                         },
  //                         icon: Icon(Icons.volume_up, size: Theme.of(context).iconTheme.size,),
  //                       )
  //                     ],
  //                   ),
  //                 )
  //             )
  //     ),
  //   );
  // }
}

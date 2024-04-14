import 'dart:convert';

import 'package:dyslexia_project/common_widgets/custom_selectable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../data/word_image_mapping.dart';
import '../../common/controllers/custom_textediting_controller.dart';
import '../../common/controllers/sound.dart';
import '../../common/views/overview_page.dart';
import '../../customizeText/controllers/text_customize_controller.dart';
import '../../customizeText/views/customize_option_page.dart';

class ReadWithSupportPage extends StatefulWidget {

  String text;

  ReadWithSupportPage({
    required this.text,
});

  @override
  State<ReadWithSupportPage> createState() => _ReadWithSupportPageState();
}

class _ReadWithSupportPageState extends State<ReadWithSupportPage> {

  final textCustomizeController = Get.put(TextCustomizeController());
  // CustomEditingController customTextEditingController = CustomEditingController();

  late int start_position;
  late int end_position;

  String selectedText = '';
  late String originalText;
  List<String> allWords = [];
  List<String> allHtmlContent = [];
  List<TextSpan> listTextSpan = [];

  void processText() {
    originalText = widget.text;
    List<String> sentences = widget.text.split('\n');
    for (int i=0;i<sentences.length;i++) {
      List<String> wordsOfASentence = sentences[i].split(' ');
      for (int j=0;j<wordsOfASentence.length;j++) {
        setState(() {
          allWords.add(wordsOfASentence[j]);
        });
      }
    }
  }

  void createHTMLContent() {
    for (int i = 0; i < allWords.length; i++) {
      String html = """<body><p>${allWords[i]}</p></body>""";
      setState(() {
        allHtmlContent.add(html);
      });
    }
  }

  void createListTextSpan() {
    for (int i = 0; i < allHtmlContent.length; i++) {
      TextSpan textSpan = HTML.toTextSpan(
        context,
        allHtmlContent[i],
        // as name suggests, optionally set the default text style
        defaultTextStyle: TextStyle(
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
            color: Colors.red,
            fontSize: textCustomizeController.currentFontSize.value.toDouble(),
            fontFamily: textCustomizeController.currentFontStyle.value,
            letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
            wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
            height: textCustomizeController.currentLineSpacing.value.toDouble()
        ),
      );
      setState(() {
        listTextSpan.add(textSpan);
      });
    }

  }

  @override
  void initState() {
    super.initState();
    // customTextEditingController.text = widget.text;
    textCustomizeController.getData();
    processText();
  }

  @override
  Widget build(BuildContext context) {


    createHTMLContent();
    createListTextSpan();
    print(allWords.length);

    String htmlContent = """
<body>

<p>${widget.text}</p>

</body>
""";
    // or use HTML.toRichText()
    final TextSpan textSpan = HTML.toTextSpan(
      context,
      htmlContent,
      linksCallback: (dynamic link) {
        debugPrint('You clicked on ${link.toString()}');
      },
      // as name suggests, optionally set the default text style
      defaultTextStyle: TextStyle(
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
          fontSize: textCustomizeController.currentFontSize.value.toDouble(),
          fontFamily: textCustomizeController.currentFontStyle.value,
          letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
          wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
          height: textCustomizeController.currentLineSpacing.value.toDouble()
      ),
      overrideStyle: <String, TextStyle>{
        'u': TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: Colors.red,
            decorationStyle: TextDecorationStyle.solid,
            color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
            fontSize: textCustomizeController.currentFontSize.value.toDouble(),
            fontFamily: textCustomizeController.currentFontStyle.value,
            letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
            wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
            height: textCustomizeController.currentLineSpacing.value.toDouble()
        ),
        'i' : TextStyle(
            fontStyle: FontStyle.italic,
            color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
            fontSize: textCustomizeController.currentFontSize.value.toDouble(),
            fontFamily: textCustomizeController.currentFontStyle.value,
            letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
            wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
            height: textCustomizeController.currentLineSpacing.value.toDouble()
        ),
        'b': TextStyle(
            fontWeight: FontWeight.bold,
            color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
            fontSize: textCustomizeController.currentFontSize.value.toDouble(),
            fontFamily: textCustomizeController.currentFontStyle.value,
            letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
            wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
            height: textCustomizeController.currentLineSpacing.value.toDouble()
        ),
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Đọc văn bản', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(OverviewPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.home, color: Colors.blue,),
                        Text('Về trang chủ', style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  )
              ),
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
      body: Obx(() => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Wrap(
                          children: [
                            for (int i = 0; i < allWords.length; i++)
                              SelectableText(
                                allWords[i],
                                onTap: () {
                                  print('tapped');
                                },
                              )

                          ],
                        ),
                        // child: SelectableText.rich(
                        //   TextSpan(
                        //   children: listTextSpan
                        //   ),
                        //   onSelectionChanged: (TextSelection selection, _) {
                        //     setState(() {
                        //       start_position = selection.baseOffset;
                        //       end_position = selection.extentOffset;
                        //       selectedText = originalText.substring(start_position, end_position);
                        //     });
                        //     print(start_position);
                        //     print(end_position);
                        //     print(originalText[start_position]);
                        //   },
                        //   contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
                        //     final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
                        //     buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                        //       return buttonItem.type == ContextMenuButtonType.cut;
                        //     });
                        //     buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                        //       return buttonItem.type == ContextMenuButtonType.copy;
                        //     });
                        //     buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                        //       return buttonItem.type == ContextMenuButtonType.selectAll;
                        //     });
                        //     buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                        //       return buttonItem.type == ContextMenuButtonType.paste;
                        //     });
                        //     return AdaptiveTextSelectionToolbar.buttonItems(
                        //       anchors: editableTextState.contextMenuAnchors,
                        //       buttonItems: buttonItems,
                        //     );
                        //   },
                        // )
                    ),
                  ),
                ],
              ),
            ),
          ),
          // some buttons here
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(28)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showImage(selectedText);
                    },
                    child: Icon(Icons.image, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(28)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      speakWord(originalText.substring(start_position, end_position));
                    },
                    child: Icon(Icons.headphones, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(28)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      boldText(start_position, end_position);
                    },
                    child: Icon(Icons.format_bold, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(28)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      underlineText(start_position, end_position);
                    },
                    child: Icon(Icons.format_underline, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(28)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      italicText(start_position, end_position);
                    },
                    child: Icon(Icons.format_italic, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(28)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      reset();
                    },
                    child: Icon(Icons.refresh, color: Colors.white,),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      )
    );
  }

  void reset() {
    setState(() {
      widget.text = originalText;
    });
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

  void boldText(int startPos, int endPos) {
    String selectedText = originalText.substring(startPos, endPos);
    int index = widget.text.indexOf(selectedText, startPos);

    String textBefore = widget.text.substring(0, index);
    String textAfter = widget.text.substring(index + selectedText.length, widget.text.length);

    setState(() {
      widget.text = textBefore + '<b>' + selectedText + '</b>' + textAfter;
    });

    print(widget.text);
    print('--------');
    for (int i=0;i<widget.text.length;i++) {
      print(widget.text[i]);
    }

  }

  void underlineText(int startPos, int endPos) {
    String selectedText = originalText.substring(startPos, endPos);
    print(selectedText);
    int index = widget.text.indexOf(selectedText, startPos);

    String textBefore = widget.text.substring(0, index);
    String textAfter = widget.text.substring(index + selectedText.length, widget.text.length);

    setState(() {
      widget.text = textBefore + '<u>' + selectedText + '</u>' + textAfter;
    });
    print(widget.text);
  }

  void italicText(int startPos, int endPos) {
    String selectedText = originalText.substring(startPos, endPos);
    int index = widget.text.indexOf(selectedText, startPos);

    String textBefore = widget.text.substring(0, index);
    String textAfter = widget.text.substring(index + selectedText.length, widget.text.length);

    setState(() {
      widget.text = textBefore + '<i>' + selectedText + '</i>' + textAfter;
    });

  }

}

import 'package:dyslexia_project/common_widgets/custom_selectable_text_widget.dart';
import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:dyslexia_project/modules/common/views/overview_page.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../../common_widgets/custom_text_widget.dart';


/// listen text page for activity 2

class ListenTextPage extends StatefulWidget {

  String text;

  ListenTextPage({
    required this.text
});

  @override
  State<ListenTextPage> createState() => _ListenTextPageState();
}

class _ListenTextPageState extends State<ListenTextPage> {

  final textCustomizeController = Get.put(TextCustomizeController());
  final ScrollController _scrollController = ScrollController();


  int currentSentenceIndex = -1;
  late List<String> paragraphList;
  late List<String> allSentences = [];

  void processText() {
    setState(() {
      paragraphList = widget.text.split('\n'); // list cac paragraph
      print(paragraphList.length);
      for (int i=0;i<paragraphList.length ;i++) {
        if (paragraphList[i].length == 1) {
          paragraphList.removeAt(i);
          i -= 1;
        } else {
          List<String> sentences = paragraphList[i].split('.');
          for (int j=0;j<sentences.length;j++) {
            sentences[j] = sentences[j].trim();
            allSentences.add(sentences[j]);
          }
        }
      }
      print(paragraphList.length);
    });
  }

  @override
  void initState() {
    super.initState();
    textCustomizeController.getData();
    processText();
    // flutterTts.setLanguage('vi-VN');
    // flutterTts.setPitch(0.8);
    // flutterTts.setSpeechRate(0.5);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nghe văn bản', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(OverviewPage());
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
                color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: allSentences.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSelectableText(
                            data: allSentences[index],
                            isSelected: index == currentSentenceIndex,
                            normalStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                                fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                fontFamily: textCustomizeController.currentFontStyle.value,
                                letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                height: textCustomizeController.currentLineSpacing.value.toDouble()
                            ),
                            selectedStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: textCustomizeController.currentFontSize.value.toDouble() + 20,
                                fontFamily: textCustomizeController.currentFontStyle.value,
                                letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                height: textCustomizeController.currentLineSpacing.value.toDouble()
                            ),
                          ),
                          SizedBox(height: 50,)
                        ],
                      );
                    }
                ),
              ),

          ),
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
                      speakCurrentSentence();
                    },
                    child: Icon(Icons.play_arrow, color: Colors.white,),
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
                      resetSpeak();
                    },
                    child: Icon(Icons.restart_alt, color: Colors.white,),
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
                      speakBefore();
                    },
                    child: Icon(Icons.navigate_before, color: Colors.white,),
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
                      speakNext();
                    },
                    child: Icon(Icons.navigate_next, color: Colors.white,),
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
                      stopSpeak();
                    },
                    child: Icon(Icons.stop, color: Colors.white,),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> speakCurrentSentence() async {
    SoundFunction().speakFast(
        allSentences[currentSentenceIndex],
        textCustomizeController.current_volume.value,
        textCustomizeController.current_rate.value - 0.1,
        textCustomizeController.current_pitch.value,
        textCustomizeController.current_voice_name.value,
        allSentences[currentSentenceIndex].split(' '),
        0);
  }

  Future<void> resetSpeak() async {
    SoundFunction().stopSpeaking();
    setState(() {
      currentSentenceIndex = -1;
    });
  }

  Future<void> speakNext() async {
    SoundFunction().stopSpeaking();
    setState(() {
      currentSentenceIndex = (currentSentenceIndex + 1) % allSentences.length;
    });
    _scrollToNextSentence(currentSentenceIndex);
     SoundFunction().speakFast(
         allSentences[currentSentenceIndex],
        textCustomizeController.current_volume.value,
        textCustomizeController.current_rate.value - 0.1,
        textCustomizeController.current_pitch.value,
        textCustomizeController.current_voice_name.value,
         allSentences[currentSentenceIndex].split(' '),
        0);
  }

  Future<void> speakBefore() async {
    SoundFunction().stopSpeaking();
    setState(() {
      currentSentenceIndex = (currentSentenceIndex - 1) % allSentences.length;
    });
    _scrollToPreviousSentence(currentSentenceIndex);
    SoundFunction().speakFast(
        allSentences[currentSentenceIndex],
        textCustomizeController.current_volume.value,
        textCustomizeController.current_rate.value - 0.1,
        textCustomizeController.current_pitch.value,
        textCustomizeController.current_voice_name.value,
        allSentences[currentSentenceIndex].split(' '),
        0);
  }

  Future<void> stopSpeak() async {
    SoundFunction().stopSpeaking();
  }

  void _scrollToNextSentence(int index) {
    double scrollPosition;
    if (currentSentenceIndex == 0) {
      scrollPosition = 0;
    } else {
      scrollPosition = _scrollController.offset + 80;
    }
    _scrollController.animateTo(
      scrollPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  void _scrollToPreviousSentence(int index) {
    double scrollPosition;
    if (currentSentenceIndex == 0) {
      scrollPosition = 0;
    } else {
      scrollPosition = _scrollController.offset - 80;
    }
    _scrollController.animateTo(
      scrollPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

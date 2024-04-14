
import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';

class SoundFunction {
  FlutterTts flutterTts = FlutterTts();

  void speak(String text, double volume, double rate, double pitch, String voiceNameCode, List<String> words, int delayBetweenWords) async {
    await flutterTts.setLanguage("vi-VN");
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    await flutterTts.setVolume(volume);
    await flutterTts.setVoice({"name" : voiceNameCode, "locale" : "vi-VN"});
    // await flutterTts.speak(text);
    print(words.length);
    for (String word in words) {
      print(word);
      if (!word.contains('-')) {
        await flutterTts.speak(word);
        await Future.delayed(Duration(seconds: 1));
      }
    }
  }

  void speakFast(String text, double volume, double rate, double pitch, String voiceNameCode, List<String> words, int delayBetweenWords) async {
    await flutterTts.setLanguage("vi-VN");
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    await flutterTts.setVolume(volume);
    await flutterTts.setVoice({"name" : voiceNameCode, "locale" : "vi-VN"});
    await flutterTts.speak(text);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }

  void getVoices() async {
    List<dynamic> list = await flutterTts.getVoices;
    int num = 0;
    for (var dynamic in list) {
      if (dynamic['locale'] == 'vi-VN') {
        print(dynamic);
        num++;
      }
    }
    print(num);
  }
}


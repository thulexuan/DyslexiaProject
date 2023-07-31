import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TextToSpeech extends GetxController{
  final FlutterTts tts = FlutterTts();
  bool isFinish = false;

  void speakNormal(String text, double volume, double rate, double pitch) async {
    await tts.setLanguage("vi-VN");
    await tts.setVolume(volume);
    await tts.setSpeechRate(rate);
    await tts.setPitch(pitch);
    await tts.speak(text);
  }

  Future<void> pause() async {
    await tts.pause();
  }
}

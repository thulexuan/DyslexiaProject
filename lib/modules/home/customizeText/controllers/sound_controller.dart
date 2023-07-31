import 'package:dyslexia_project/modules/common/controllers/text_to_speech.dart';
import 'package:get/get.dart';

class SoundController extends GetxController {
  var current_volume = 0.5.obs;
  var current_rate = 0.5.obs;
  var current_pitch = 0.5.obs;

  speak(String text) {
    TextToSpeech().speakNormal(text, current_volume.value, current_rate.value, current_pitch.value);
  }
}
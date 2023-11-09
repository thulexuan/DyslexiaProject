import 'package:dyslexia_project/modules/common/controllers/text_to_speech.dart';
import 'package:get/get.dart';

class SoundController extends GetxController {
  var current_volume = 0.5.obs;
  var current_rate = 0.5.obs;
  var current_pitch = 0.5.obs;

  var voiceSelectedIndex = 0.obs;

  List<String> voiceNameCodeList = [
    'vi-vn-x-vid-local',
    'vi-vn-x-vic-local',
    'vi-vn-x-gft-network',
    'vi-vn-x-vie-local',
    'vi-vn-x-vic-network',
    'vi-vn-x-gft-local',
    'vi-vn-x-vid-network',
    'vi-vn-x-vif-local',
    'vi-vn-x-vif-network',
    'vi-VN-language',
    'vi-vn-x-vie-network'
  ];


}
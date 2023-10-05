import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/sound_controller.dart';

class SoundCustomizeOptionPage extends StatefulWidget {
  const SoundCustomizeOptionPage({Key? key}) : super(key: key);

  @override
  State<SoundCustomizeOptionPage> createState() => _SoundCustomizeOptionPageState();
}

class _SoundCustomizeOptionPageState extends State<SoundCustomizeOptionPage> {

  final textEditingController = TextEditingController();
  final soundController = Get.put(SoundController());

  double _currentSliderValue = 0.2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = "Đây là bản xem trước";
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
           TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue, // Set your desired border color here
                  width: 2.0, // Set the border width
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)), // Set the border radius
              ),
            ),
          ),
          Row(
            children: <Widget>[
              const Text('Âm lượng', style: TextStyle(fontWeight: FontWeight.bold),),
              Expanded(
                child: Obx(() => Slider(
                  value: soundController.current_volume.value,
                  min: 0,
                  max: 1,
                  onChanged: (double value) {
                    soundController.current_volume.value = value;
                  },
                ),)
              ),
              Obx(() => Text(soundController.current_volume.value.toStringAsFixed(1).toString()),)
            ],
          ),
          Row(
            children: <Widget>[
              const Text('Tốc độ', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                  child: Obx(() => Slider(
                    value: soundController.current_rate.value,
                    min: 0,
                    max: 2,
                    onChanged: (double value) {
                      soundController.current_rate.value = value;
                    },
                  ),)
              ),
              Obx(() => Text(soundController.current_rate.value.toStringAsFixed(1).toString()),)
            ],
          ),
          Row(
            children: <Widget>[
              const Text('Tông giọng', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                  child: Obx(() => Slider(
                    value: soundController.current_pitch.value,
                    min: 0,
                    max: 2,
                    onChanged: (double value) {
                      soundController.current_pitch.value = value;
                    },
                  ),)
              ),
              Obx(() => Text(soundController.current_pitch.value.toStringAsFixed(1).toString()),)
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Nghe thử'),
                IconButton(
                    icon: Icon(Icons.volume_up),
                    onPressed: () {
                      soundController.speak(textEditingController.text);
                    },
                  )
              ],
            ),
        ],
      ),
    );
  }
}

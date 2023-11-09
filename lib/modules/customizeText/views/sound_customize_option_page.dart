import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:dyslexia_project/modules/customizeText/views/components/voice_option_item.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = "Rùa và thỏ";
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    max: 1,
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
                    max: 1,
                    onChanged: (double value) {
                      soundController.current_pitch.value = value;
                    },
                  ),)
              ),
              Obx(() => Text(soundController.current_pitch.value.toStringAsFixed(1).toString()),)
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Giọng đọc', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          const Divider(thickness: 2.0,),
          Expanded(
              child: ListView.separated(
                  itemCount: soundController.voiceNameCodeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(() => GestureDetector(
                        onTap: () {
                          soundController.voiceSelectedIndex.value = index;
                        },
                        child: VoiceOptionItem(voiceName: 'Giọng số ${index+1}', isSelected: soundController.voiceSelectedIndex.value == index,)
                    )
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 2.0,); },
              )
          ),
          const Divider(thickness: 2.0,),
          Center(
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  SoundFunction().speak(
                      textEditingController.text,
                      soundController.current_volume.value,
                      soundController.current_rate.value,
                      soundController.current_pitch.value,
                      soundController.voiceNameCodeList[soundController.voiceSelectedIndex.value]
                  );
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text('Nghe thử', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      IconButton(
                          icon: Icon(Icons.volume_up, size: 35,),
                          onPressed: () {

                          },
                        )
                    ],
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

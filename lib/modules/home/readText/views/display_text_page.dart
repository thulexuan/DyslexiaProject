import 'dart:io';

import 'package:dyslexia_project/modules/common/controllers/text_to_speech.dart';
import 'package:dyslexia_project/modules/home/customizeText/controllers/text_customize_controller.dart';
import 'package:dyslexia_project/modules/home/readText/controllers/recognize_text_controller.dart';
import 'package:dyslexia_project/modules/home/customizeText/views/customize_option_page.dart';
import 'package:dyslexia_project/modules/home/readText/views/read_options_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../customizeText/controllers/sound_controller.dart';

class DisplayTextPage extends StatefulWidget {

  @override
  State<DisplayTextPage> createState() => _DisplayTextPageState();

  final String text;

  DisplayTextPage({
    required this.text
});
}

class _DisplayTextPageState extends State<DisplayTextPage>
    with SingleTickerProviderStateMixin{
  final controller = Get.put(RecognizedTextController());
  final textCustomizeController = Get.put(TextCustomizeController());
  final soundCustomizeController = Get.put(SoundController());
  final textEditingController = TextEditingController();
  late TabController _tabController;

  bool isPause = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = controller.extractedText.value;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display text'),),
      body: Column(
        children: [
          Obx(() =>
              controller.extractedText.value.isEmpty?
              const Center(child: Text("Text Not Found")):
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height - 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Column(
                  children: [
                    Container(
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.teal,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.teal,
                        tabs: const [
                          Tab(child: Text('Text',
                            style: TextStyle(fontSize: 18,),)
                          ),
                          Tab(child: Text('Image',
                            style: TextStyle(fontSize: 18,),),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      // width: double.maxFinite,
                      // height: MediaQuery.of(context).size.height - 170,
                      child: TabBarView(
                        controller: _tabController,
                        children:  [
                          SingleChildScrollView(
                              child: TextField(
                                controller: textEditingController,
                                maxLines: null,
                                style: TextStyle(
                                  fontSize: textCustomizeController.current_font_size.value.toDouble(),
                                ),
                              )
                          ),
                          controller.selectedImagePath.value==''?
                          const Center(child: Text("Select an image from Gallery / camera")):
                          Image.file(
                            File(controller.selectedImagePath.value),
                            width: Get.width,
                            //height: 400,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.camera_alt_sharp),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ReadOptions()),
                    );
                  },
                ),
                IconButton(
                    icon: isPause ? Icon(Icons.play_circle) : Icon(Icons.pause),
                    onPressed: () {
                      setState(() {
                        isPause = !isPause;
                      });
                      isPause ? TextToSpeech().pause() : TextToSpeech().speakNormal(textEditingController.text,
                          soundCustomizeController.current_volume.value,
                          soundCustomizeController.current_rate.value,
                          soundCustomizeController.current_pitch.value);
                    }
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  CustomizeOptionPage()),
                      );
                    },
                    icon: Icon(Icons.toc),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

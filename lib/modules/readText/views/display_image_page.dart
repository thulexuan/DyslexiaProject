import 'dart:io';

import 'package:dyslexia_project/modules/common/controllers/custom_textediting_controller.dart';
import 'package:dyslexia_project/modules/readText/views/read_options_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/recognize_text_controller.dart';
import 'display_text_page.dart';

class DisplayImagePage extends StatefulWidget {
   DisplayImagePage({Key? key}) : super(key: key);

  @override
  State<DisplayImagePage> createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  final controller = Get.put(RecognizedTextController());
  var isRecognizerLoading = false;

  CustomEditingController customEditingController = CustomEditingController();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(title: Text('Ảnh được chọn', style: Theme.of(context).textTheme.labelSmall,),
          toolbarHeight: MediaQuery.of(context).size.height / 12),
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 4 / 5 : MediaQuery.of(context).size.height * 3 / 4,
                  child: Obx(() =>
                  controller.selectedImagePath.value==''?
                  Center(child: Text("Chụp ảnh hoặc chọn ảnh từ thư viện", style: Theme.of(context).textTheme.bodyLarge,))
                      :
                  Image.file(
                    File(controller.selectedImagePath.value),
                    width: Get.width,
                    //height: 400,
                  ),

                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await controller.cropImage(controller.selectedImagePath.value);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cắt ảnh', style: Theme.of(context).textTheme.labelSmall,),
                      )
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isRecognizerLoading = true;
                        });
                        await controller.recognizeTextByAPI(controller.selectedImagePath.value);
                        setState(() {
                          isRecognizerLoading = false;
                        });
                        if (controller.ocrDone.value == false) {
                          showDialogOCRFail(context);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  DisplayTextPage(text: controller.extractedText.value)),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Đọc văn bản', style: Theme.of(context).textTheme.labelSmall),
                      ))
                ],
              )

            ],
          ),
          if (isRecognizerLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<void> showDialogOCRFail(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Thử lại'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Okay'),
                onPressed: () {
                  Get.to(const ReadOptions());
                },
              ),
            ],
          );
        }
    );
  }
}

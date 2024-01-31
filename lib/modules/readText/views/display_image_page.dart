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
    return Scaffold(
      appBar: AppBar(title: Text('Ảnh được chọn'),),
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: MediaQuery.of(context).size.height - 220,
                  child: Obx(() =>
                  controller.selectedImagePath.value==''?
                  const Center(child: Text("Chụp ảnh hoặc chọn ảnh từ thư viện"))
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cắt ảnh', style: TextStyle(fontSize: 20),),
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Đọc văn bản', style: TextStyle(fontSize: 20)),
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

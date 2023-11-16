import 'dart:io';

import 'package:dyslexia_project/modules/common/controllers/custom_textediting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/recognize_text_controller.dart';
import 'display_text_page.dart';

class DisplayImagePage extends StatelessWidget {
   DisplayImagePage({Key? key}) : super(key: key);

  final controller = Get.put(RecognizedTextController());
  CustomEditingController customEditingController = CustomEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ảnh được chọn'),),
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                height: MediaQuery.of(context).size.height - 220,
                child: Obx(() =>
                controller.selectedImagePath.value==''?
                const Center(child: Text("Select an image from Gallery / camera"))
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
                      await controller.recognizedText(controller.selectedImagePath.value);
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

      ),
    );
  }
}

import 'dart:io';

import 'package:dyslexia_project/modules/home/readText/views/display_text_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/recognize_text_controller.dart';

class DisplayImagePage extends StatelessWidget {
   DisplayImagePage({Key? key}) : super(key: key);

  final controller = Get.put(RecognizedTextController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Image'),),
      body: Container(
        child: Column(
          children: [
            Obx(()=>

            controller.selectedImagePath.value==''?
            const Center(child: Text("Select an image from Gallery / camera")):
            Image.file(
              File(controller.selectedImagePath.value),
              width: Get.width,
              //height: 400,
            ),
            ),
            TextButton(
                onPressed: () async {
                  await controller.recognizedText(controller.selectedImagePath.value);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  DisplayTextPage(text: controller.extractedText.value)),
                  );
                },
                child: Text('Scan text'))
          ],
        ),

      ),
    );
  }
}

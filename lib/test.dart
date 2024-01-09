import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'modules/readText/controllers/recognize_text_controller.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  // final String _url = "https://backend.scandocflow.com/v1/api/documents/extract?access_token=";

  final String _token = "9LQDrEth3UIFBA5NN6Kby5hj5EY8rqhMtmg9F4DpSAf0eCFabxSC70sZhgTrveWx";

  late StreamController _streamController;

  final controller = Get.put(RecognizedTextController());

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('Test'),),
      body: SingleChildScrollView(
        child: Column(
          children: [

            ElevatedButton(
                onPressed: () {
                  controller.getImage(ImageSource.gallery);
                  print(controller.selectedImagePath.value);
                },
                child: Text('Pick image')
            ),
            controller.selectedImagePath.value == '' ? Text('no image') :
            Obx(() => Image.file(
              File(controller.selectedImagePath.value),
              width: Get.width,
              //height: 400,
            )),
            ElevatedButton(
                onPressed: () {
                  controller.recognizeTextByAPI(controller.selectedImagePath.value);
                },
                child: Text('Scan text')
            ),
            controller.extractedText.value == null ? Text('no text') : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(controller.extractedText.value),
            ),
          ],
        ),
      ),
    );
  }



}


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizedTextController extends GetxController {

  FlutterTts flutterTts = FlutterTts();

  var selectedImagePath=''.obs;
  var extractedText=''.obs;
  RxList words = [].obs;

  ///get image method
  getImage(ImageSource imageSource) async{
    print("get image oke");
    final pickedFile= await ImagePicker().pickImage(source: imageSource);
    if(pickedFile!=null){
      selectedImagePath.value = pickedFile.path;
    }
    else{
      Get.snackbar(
          "Error", "image is not selected",
          backgroundColor: Colors.red);
    }


  }

  cropImage(String pickedImage) async {

    if (pickedImage != null) { // imageFile = File(pickedImage.path);

      File pickedFile = File(pickedImage);

      CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          maxHeight: 4096,
          maxWidth: 4096,
          aspectRatioPresets:
          [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],

          uiSettings: [
          AndroidUiSettings(
          toolbarTitle: 'Cắt ảnh',
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
          IOSUiSettings(title: 'Cắt ảnh')
      ]);

      if (cropped != null) {
      selectedImagePath.value = cropped.path;
      }
    }
  }

  ///recognise image text method
  Future<void> recognizedText(String pickedImage) async {
    if (pickedImage == null) {
      Get.snackbar(
          "Error", "image is not selected",
          backgroundColor: Colors.red);
    }
    else {
      extractedText.value = '';
      words.value = [];
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final inputImage = InputImage.fromFilePath(pickedImage);
      try{

        final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

        for (TextBlock block in recognizedText.blocks) {
          for (TextLine line in block.lines) {
            for (TextElement element in line.elements) {
              extractedText.value='${extractedText.value}${element.text} ';
              if (element != null) {
                words.add(element.text);
              }
            }
            extractedText.value="${extractedText.value} \n";
          }
        }

        // String text = await FlutterTesseractOcr.extractText(pickedImage, language: 'vie+eng',
        //     args: {
        //       "psm": "4",
        //       "preserve_interword_spaces": "1",
        //     });
        // extractedText.value = text;



        // var visionText= await textRecognizer.processImage(visionImage);
        // for(TextBlock textBlock in visionText.blocks){
        //   for(TextLine textLine in textBlock.lines){
        //     for(TextElement textElement in textLine.elements){
        //       extractedText.value='${extractedText.value}${textElement.text} ';
        //       if (textElement.text != ' ') {
        //         words.add(textElement.text);
        //       }
        //     }
        //     extractedText.value="${extractedText.value} \n";
        //   }
        // }
        for (int i=0;i<words.length;i++) {
          print(words[i]);
        }
        print(words.length);
      }
      catch(e){
        Get.snackbar(
            "Error", e.toString(),
            backgroundColor: Colors.red);
      }
    }
  }

  speak(List words) async {
    await flutterTts.setLanguage('vi-VN');
    for (int i=0;i<words.length;i++) {
      String currentWord = words.elementAt(i).text.toString();
      print(currentWord);
      await flutterTts.speak(currentWord);
    }

  }

}
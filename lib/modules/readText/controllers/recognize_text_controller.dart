import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizedTextController extends GetxController {

  var selectedImagePath=''.obs;
  var extractedText=''.obs;
  RxList words = [].obs;

  ///get image method
  getImage(ImageSource imageSource) async{
    print("oke");
    final pickedFile= await ImagePicker().pickImage(source: imageSource);
    if(pickedFile!=null){
      selectedImagePath.value=pickedFile.path;
    }
    else{
      Get.snackbar(
          "Error", "image is not selected",
          backgroundColor: Colors.red);
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
            }
            extractedText.value="${extractedText.value} \n";
          }
        }

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
          print('\n');
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
}
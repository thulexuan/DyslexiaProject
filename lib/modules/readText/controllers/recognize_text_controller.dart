
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;

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

  Future<Map<String, dynamic>> recognizeTextByAPI(String pickedImage) async {

    print('start');
    // Create a multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://ocr-tool-dd06f654802f.herokuapp.com/api/v1/extract_text'),
    );

    // request.headers.addAll({
    //   'Content-Type': 'multipart/form-data',
    //   'Apikey': '0d1d50c8-3c1b-4453-bf87-27b556c29169',
    //   'Accept': 'application/json',
    //   'language': 'VIE'
    // });

    // Add the file to the request
    request.files.add(await http.MultipartFile.fromPath('image', pickedImage));

    // Add other fields to the request
    // request.fields['type'] = 'ocr';
    // request.fields['lang'] = 'auto';
    // request.fields['retain'] = 'true';


    try {
      // Send the request
      final response = await request.send();

      print(response.statusCode);

      // Check if the request was successful (status code 2xx)
      if (response.statusCode == 200) {
        // Decode and return the response
        final resultString = await response.stream.bytesToString();
        print(json.decode(resultString));
        extractedText.value = json.decode(resultString)['text'];
        return json.decode(resultString);
      } else {
        // Handle the error
        print('Failed to call API. Status code: ${response.statusCode}');
        print(await response.stream.bytesToString());
        throw Exception('Failed to call API.');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      throw Exception('Failed to call API.');
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
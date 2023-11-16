import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomEditingController extends TextEditingController {

  final textCustomizeController = Get.put(TextCustomizeController());

  var errorWords = [].obs;
  var done = false.obs;

  Future<void> getErrorWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: prefs.getString('email')).get();

    final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    errorWords.value = data != null && data is Map<String, dynamic>
        ? data['errorWords']
        : [] ;

    done.value = true;
    notifyListeners();
  }


  // @override
  // TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
  //
  //   getErrorWords();
  //
  //   final words = text.split('');
  //   final textSpanChildren = <TextSpan>[];
  //
  //   // Add your text styling rules
  //   for (final word in words) {
  //     TextStyle wordStyle;
  //
  //     wordStyle = TextStyle(
  //         color: textCustomizeController.textColor.elementAt(
  //             textCustomizeController.textColor_text.indexOf(
  //                 textCustomizeController.currentTextColor.value)),
  //         fontSize: textCustomizeController.currentFontSize.value.toDouble(),
  //         fontFamily: textCustomizeController.currentFontStyle.value,
  //         letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
  //         wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
  //         height: textCustomizeController.currentLineSpacing.value.toDouble()
  //     );
  //
  //     for (var errorWord in errorWords) {
  //       if (word == errorWord) {
  //         wordStyle = TextStyle(
  //             color: Colors.blue,
  //             fontWeight: FontWeight.bold,
  //             fontSize: textCustomizeController.currentFontSize.value.toDouble(),
  //             fontFamily: textCustomizeController.currentFontStyle.value,
  //             letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
  //             wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
  //             height: textCustomizeController.currentLineSpacing.value.toDouble()
  //         );
  //       }
  //     }
  //
  //     final child = TextSpan(text: word, style: wordStyle);
  //     textSpanChildren.add(child);
  //
  //     // Add the space back in
  //     //textSpanChildren.add(TextSpan(text: ' '));
  //   }
  //   return TextSpan(children: textSpanChildren);
  // }

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {

    getErrorWords();

    Map<String, TextStyle> mapping = {
      'b' : TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: textCustomizeController.currentFontSize.value.toDouble(), fontFamily: textCustomizeController.currentFontStyle.value, letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(), wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(), height: textCustomizeController.currentLineSpacing.value.toDouble()),
      'd' : TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: textCustomizeController.currentFontSize.value.toDouble(), fontFamily: textCustomizeController.currentFontStyle.value, letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(), wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(), height: textCustomizeController.currentLineSpacing.value.toDouble()),
      'p' : TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: textCustomizeController.currentFontSize.value.toDouble(), fontFamily: textCustomizeController.currentFontStyle.value, letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(), wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(), height: textCustomizeController.currentLineSpacing.value.toDouble()),
      'q' : TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: textCustomizeController.currentFontSize.value.toDouble(), fontFamily: textCustomizeController.currentFontStyle.value, letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(), wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(), height: textCustomizeController.currentLineSpacing.value.toDouble()),
      'm' : TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: textCustomizeController.currentFontSize.value.toDouble(), fontFamily: textCustomizeController.currentFontStyle.value, letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(), wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(), height: textCustomizeController.currentLineSpacing.value.toDouble()),
      'n' : TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: textCustomizeController.currentFontSize.value.toDouble(), fontFamily: textCustomizeController.currentFontStyle.value, letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(), wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(), height: textCustomizeController.currentLineSpacing.value.toDouble()),
      'u' : TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: textCustomizeController.currentFontSize.value.toDouble(), fontFamily: textCustomizeController.currentFontStyle.value, letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(), wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(), height: textCustomizeController.currentLineSpacing.value.toDouble()),
    };


    List<String> words = text.split(' ');

    List<List<TextSpan>> wordSpans = words.map((word) {
      List<TextSpan> letterSpans = word.runes.map((rune) {
        String letter = String.fromCharCode(rune);
        if (errorWords.contains(letter)) {
          return TextSpan(
            text: letter,
            style: mapping[letter],
          );
        } else {
          return TextSpan(
            text: letter,
            style: style?.copyWith(
              letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
              color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
            ),
          );
        }
      }).toList();

      return letterSpans;
    }).toList();

    List<InlineSpan> finalSpans = [];
    wordSpans.forEach((wordSpan) {
      finalSpans.addAll(wordSpan);
      finalSpans.add(TextSpan(text: ' ', style: TextStyle(letterSpacing: textCustomizeController.currentWordSpacing.value))); // Add space between words
    });

    return TextSpan(children: finalSpans, );
  }

}
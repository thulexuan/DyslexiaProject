import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/controllers/sound.dart';

class QuestionOption extends StatelessWidget {

  bool isSelected = false;
  String content;

  final textCustomizeController = Get.put(TextCustomizeController());

  QuestionOption({
    required this.isSelected,
    required this.content
});

  @override
  Widget build(BuildContext context) {
    textCustomizeController.getData();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: isSelected ? Colors.redAccent : Colors.grey,
            width: isSelected ? 2 : 0
          )
        ),
        width: double.infinity / 2,
        // height: 200,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon(isSelected == true ? Icons.radio_button_checked : Icons.radio_button_off, size: textCustomizeController.currentFontSize.value.toDouble() ,),
              // SizedBox(width: 8,),
              Flexible(
                // padding: const EdgeInsets.all(8.0),
                child: Text(content,
                    style: TextStyle(
                        color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                        fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                        fontFamily: textCustomizeController.currentFontStyle.value,
                        letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                        wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                        height: textCustomizeController.currentLineSpacing.value.toDouble()
                    ),
                  ),

              ),
              IconButton(onPressed: () {
                SoundFunction().speakFast(
                    content,
                    textCustomizeController.current_volume.value,
                    textCustomizeController.current_rate.value,
                    textCustomizeController.current_pitch.value,
                    textCustomizeController.current_voice_name.value,
                    content.split(' '),
                    0);
              }, icon: Icon(Icons.volume_up))
            ],
          ),
        ),
      ),
    );
  }
}

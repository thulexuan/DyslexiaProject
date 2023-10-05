import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestOption extends StatelessWidget {

  int index;
  String? content;
  double? size;
  int questionIndex;
  // String fontType;
  double? characterSpacing;
  // double lineSpacing;

  TestOption({super.key,
    required this.index,
    required this.questionIndex,
    required this.content,
    required this.size,
    required this.characterSpacing
});

  final controller = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    print("ode");
    print(controller.selectedOption.value[questionIndex]);
    return Obx(() => Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: index == controller.selectedOption[questionIndex] ? Colors.yellowAccent : Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1,
            )
        ),
        child: Text(content!, style: TextStyle(fontSize: size, letterSpacing: characterSpacing),),
      ),
    )
    );



  }
}

import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/widgets/testCustomizeTemplate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestCustomizePage extends StatefulWidget {
  const TestCustomizePage({Key? key}) : super(key: key);

  @override
  State<TestCustomizePage> createState() => _TestCustomizePageState();
}

class _TestCustomizePageState extends State<TestCustomizePage> {

  final controller = Get.put(TestController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              itemBuilder: (BuildContext context,int index) {
                return TestCustomizeTemplate(question: controller.questions[index], questionIndex: index,);
              },
              itemCount: controller.questions.length,
              onPageChanged: controller.updateQuestionIndex,
            )

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    controller.pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.ease);
                  },
                  child: Text('Câu trước')
              ),
              SizedBox(width: 10,),
              ElevatedButton(
                    onPressed: () {
                      controller.pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
                    },
                    child: Text('Câu sau')
              ),
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

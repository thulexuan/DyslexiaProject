import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../customizeText/controllers/text_customize_controller.dart';
import '../controllers/test_controller.dart';
import 'common_widgets/questionItem.dart';
import 'common_widgets/test_contrast_item.dart';

class TestBackgroundPage extends StatefulWidget {

  String letter;
  int quesNum;

  TestBackgroundPage({super.key,
    required this.letter,
    required this.quesNum
  });

  @override
  State<TestBackgroundPage> createState() => _TestBackgroundPageState();
}

class _TestBackgroundPageState extends State<TestBackgroundPage> {

  final testController = Get.put(TestController());
  final textCustomizeController = Get.put(TextCustomizeController());

  int selectedIndex = -1;

  late List<int> position;

  List<int> generateArray() {
    Random random = Random();
    List<int> array = List<int>.generate(4, (index) => random.nextInt(4));

    // Ensure none of the elements are equal
    while (!isUnique(array)) {
      array = List<int>.generate(4, (index) => random.nextInt(4));
    }

    return array;
  }

  bool isUnique(List<int> array) {
    for (int i = 0; i < array.length; i++) {
      for (int j = i + 1; j < array.length; j++) {
        if (array[i] == array[j]) {
          return false;
        }
      }
    }
    return true;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    position = generateArray();
  }


  @override
  Widget build(BuildContext context) {
    List<List<double>> positionValue = [
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 0.6 / 3],
      [MediaQuery.of(context).size.height / 2.2 + 200, MediaQuery.of(context).size.width * 0.6 / 3],
      [MediaQuery.of(context).size.height / 2.2 + 200, MediaQuery.of(context).size.width * 2 / 3],
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 2 / 3]
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10,),
              QuestionItem(question: 'Hãy chọn chữ bạn cho là dễ nhìn nhất',),
              SizedBox(height: MediaQuery.of(context).size.height / 8,),
            ],
          ),

          // display choices here

          // off-black / off-white
          Positioned(
            top: positionValue[position[0]][0],
            left: positionValue[position[0]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                testController.answers[widget.quesNum] = 0;
              },
              child: TestContrastItem(
                word: widget.letter,
                fontSize: 30,
                isSelected: selectedIndex == 0 ? true : false,
                fontFamily: 'Arial',
                backgroundColor: Color.fromRGBO(255, 255, 229, 1), opacity: 1, textColor: Color.fromRGBO(10, 10, 10, 1),
              ),
            ),
          ),
          // black / white
          Positioned(
            top: positionValue[position[1]][0],
            left: positionValue[position[1]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                testController.answers[widget.quesNum] = 1;
              },
              child: TestContrastItem(
                word: widget.letter,
                fontSize: 30,
                isSelected: selectedIndex == 1 ? true : false,
                fontFamily: 'Arial',
                backgroundColor: Colors.white, opacity: 1, textColor: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[2]][0],
            left: positionValue[position[2]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                testController.answers[widget.quesNum] = 2;
              },
              child: TestContrastItem(
                word: widget.letter,
                fontSize: 30,
                isSelected: selectedIndex == 2 ? true : false,
                fontFamily: 'Arial',
                backgroundColor: Color.fromRGBO(250, 250, 200, 1), opacity: 1, textColor: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[3]][0],
            left: positionValue[position[3]][1],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
                testController.answers[widget.quesNum] = 3;
              },
              child: TestContrastItem(
                word: widget.letter,
                fontSize: 30,
                isSelected: selectedIndex == 3 ? true : false,
                fontFamily: 'Arial',
                backgroundColor: Color.fromRGBO(255, 255, 0, 1), opacity: 1, textColor: Color.fromRGBO(0, 0, 125, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


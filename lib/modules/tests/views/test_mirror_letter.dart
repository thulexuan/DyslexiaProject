import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:dyslexia_project/modules/tests/views/common_widgets/mirror_letter_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/controllers/sound.dart';

class TestMirrorPage extends StatefulWidget {

  @override
  State<TestMirrorPage> createState() => _TestMirrorPageState();

  int quesNum;
  String letter;

  TestMirrorPage({
    required this.letter,
    required this.quesNum,
});
}

class _TestMirrorPageState extends State<TestMirrorPage> {

  final testController = Get.put(TestController());

  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> letter_mirror_pairs = {
      'd': ['b', 'd', 'p'],
      'q': ['p', 'q', 'b'],
      'n': ['m', 'n', 'u'],
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // loa phát yêu cầu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/pointing.gif', width: 60, height: 60,),
                      IconButton(
                          onPressed: () {
                            SoundFunction().speak('Hãy chọn chữ ${widget.letter} mà bạn thấy dễ đọc nhất', 1.0, 0.5, 0.8, 'vi-vn-x-gft-network');
                          },
                          icon: const Icon(Icons.volume_up, size: 40, color: Colors.white,)
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.question_mark, size: 35, color: Colors.white,),
                      Flexible(
                          child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Chọn chữ  ',
                                    style: TextStyle(
                                      fontSize: 20,
                                    )
                                  ),
                                  TextSpan(
                                    text: widget.letter,
                                    style: const TextStyle(
                                      fontSize: 40,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  const TextSpan(
                                    text: '  mà bạn thấy dễ đọc nhất',
                                    style: TextStyle(fontSize: 20)
                                  )
                                ]
                              )
                          )
                      )
                    ],
                  )

                ]
            ),
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  testController.answers[widget.quesNum] = 0;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][0],
                    fontFamily: 'Arial',
                    fontSize: 24,
                    isSelected: selectedIndex == 0 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  testController.answers[widget.quesNum] = 1;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][1],
                    fontFamily: 'Arial',
                    fontSize: 24,
                    isSelected: selectedIndex == 1 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  testController.answers[widget.quesNum] = 2;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][2],
                    fontFamily: 'Arial',
                    fontSize: 24,
                    isSelected: selectedIndex == 2 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                  testController.answers[widget.quesNum] = 3;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][0],
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    isSelected: selectedIndex == 3 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                  testController.answers[widget.quesNum] = 4;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][1],
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    isSelected: selectedIndex == 4 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 5;
                  });
                  testController.answers[widget.quesNum] = 5;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][2],
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    isSelected: selectedIndex == 5 ? true : false,
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 6;
                  });
                  testController.answers[widget.quesNum] = 6;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][0],
                    fontFamily: 'Arial',
                    fontSize: 35,
                    isSelected: selectedIndex == 6 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 7;
                  });
                  testController.answers[widget.quesNum] = 7;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][1],
                    fontFamily: 'Arial',
                    fontSize: 35,
                    isSelected: selectedIndex == 7 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 8;
                  });
                  testController.answers[widget.quesNum] = 8;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][2],
                    fontFamily: 'Arial',
                    fontSize: 35,
                    isSelected: selectedIndex == 8 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 9;
                  });
                  testController.answers[widget.quesNum] = 9;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][0],
                    fontFamily: 'Times New Roman',
                    fontSize: 35,
                    isSelected: selectedIndex == 9 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 10;
                  });
                  testController.answers[widget.quesNum] = 10;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][1],
                    fontFamily: 'Times New Roman',
                    fontSize: 35,
                    isSelected: selectedIndex == 10 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 11;
                  });
                  testController.answers[widget.quesNum] = 11;
                },
                child: MirrorLetterItem(
                    letter: letter_mirror_pairs[widget.letter][2],
                    fontFamily: 'Times New Roman',
                    fontSize: 35,
                    isSelected: selectedIndex == 11 ? true : false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

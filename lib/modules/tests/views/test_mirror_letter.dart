import 'dart:math';

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

  late List<int> position;

  List<int> generateArray() {
    Random random = Random();
    List<int> array = List<int>.generate(12, (index) => random.nextInt(12));

    // Ensure none of the elements are equal
    while (!isUnique(array)) {
      array = List<int>.generate(12, (index) => random.nextInt(12));
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

    Map<String, dynamic> letter_mirror_pairs = {
      'd': ['b', 'd', 'p'],
      'q': ['p', 'q', 'b'],
      'n': ['m', 'n', 'u'],
    };

    List<List<double>> positionValue = [
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width / 7],
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 2 / 7],
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 3 / 7],
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 4 / 7],
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 5 / 7],
      [MediaQuery.of(context).size.height / 2.2, MediaQuery.of(context).size.width * 6 / 7],
      [MediaQuery.of(context).size.height / 1.5, MediaQuery.of(context).size.width * 1 / 7],
      [MediaQuery.of(context).size.height / 1.5, MediaQuery.of(context).size.width * 2 / 7],
      [MediaQuery.of(context).size.height / 1.5, MediaQuery.of(context).size.width * 3 / 7],
      [MediaQuery.of(context).size.height / 1.5, MediaQuery.of(context).size.width * 4 / 7],
      [MediaQuery.of(context).size.height / 1.5, MediaQuery.of(context).size.width * 5 / 7],
      [MediaQuery.of(context).size.height / 1.5, MediaQuery.of(context).size.width * 6 / 7],
    ];

    print(position);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: MediaQuery.of(context).size.height / 10),
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
                    children: [
                      // loa phát yêu cầu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/pointing.gif', width: Theme.of(context).iconTheme.size, height: Theme.of(context).iconTheme.size,),
                          IconButton(
                              onPressed: () {
                                SoundFunction().speakFast('Hãy chọn chữ ${widget.letter} mà bạn thấy dễ đọc nhất', 1.0, 0.5, 0.8, 'vi-vn-x-gft-network', 'Hãy chọn chữ ${widget.letter} mà bạn thấy dễ đọc nhất'.split(' '), 0);
                              },
                              icon: Icon(Icons.volume_up, size: Theme.of(context).iconTheme.size, color: Colors.white,)
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.question_mark, size: Theme.of(context).iconTheme.size, color: Colors.white,),
                          Flexible(
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Hãy chọn chữ  ',
                                            style: Theme.of(context).textTheme.labelSmall
                                        ),
                                        TextSpan(
                                            text: widget.letter,
                                            style: const TextStyle(
                                                fontSize: 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: '  mà bạn thấy dễ đọc nhất',
                                            style: Theme.of(context).textTheme.labelSmall
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
            ],
          ),
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
              child: MirrorLetterItem(
                letter: letter_mirror_pairs[widget.letter][0],
                fontFamily: 'Arial',
                fontSize: 24,
                isSelected: selectedIndex == 0 ? true : false,
              ),
            ),
          ),
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
              child: MirrorLetterItem(
                letter: letter_mirror_pairs[widget.letter][1],
                fontFamily: 'Arial',
                fontSize: 24,
                isSelected: selectedIndex == 1 ? true : false,
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
              child: MirrorLetterItem(
                letter: letter_mirror_pairs[widget.letter][2],
                fontFamily: 'Arial',
                fontSize: 24,
                isSelected: selectedIndex == 2 ? true : false,
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
              child: MirrorLetterItem(
                letter: letter_mirror_pairs[widget.letter][0],
                fontFamily: 'Times New Roman',
                fontSize: 24,
                isSelected: selectedIndex == 3 ? true : false,
              ),
            ),
          ),
          Positioned(
            top: positionValue[position[4]][0],
            left: positionValue[position[4]][1],
            child: GestureDetector(
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
          ),
          Positioned(
            top: positionValue[position[5]][0],
            left: positionValue[position[5]][1],
            child: GestureDetector(
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
          ),
          Positioned(
            top: positionValue[position[6]][0],
            left: positionValue[position[6]][1],
            child: GestureDetector(
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
          ),
          Positioned(
            top: positionValue[position[7]][0],
            left: positionValue[position[7]][1],
            child: GestureDetector(
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
          ),
          Positioned(
            top: positionValue[position[8]][0],
            left: positionValue[position[8]][1],
            child: GestureDetector(
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
          ),
          Positioned(
            top: positionValue[position[9]][0],
            left: positionValue[position[9]][1],
            child: GestureDetector(
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
          ),
          Positioned(
            top: positionValue[position[10]][0],
            left: positionValue[position[10]][1],
            child: GestureDetector(
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
          ),
          Positioned(
            top: positionValue[position[11]][0],
            left: positionValue[position[11]][1],
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }
}

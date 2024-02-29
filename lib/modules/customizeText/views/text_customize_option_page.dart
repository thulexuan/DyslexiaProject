import 'package:dyslexia_project/common_widgets/counter.dart';
import 'package:dyslexia_project/common_widgets/text_custom_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../data/color_mapping.dart';
import '../../../common_widgets/background_option.dart';
import '../controllers/text_customize_controller.dart';

class TextCustomizeOptionPage extends StatefulWidget {
  const TextCustomizeOptionPage({Key? key}) : super(key: key);

  @override
  State<TextCustomizeOptionPage> createState() => _TextCustomizeOptionPageState();
}

class _TextCustomizeOptionPageState extends State<TextCustomizeOptionPage> {

  final textCustomizeController = Get.put(TextCustomizeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textCustomizeController.getData();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    print(textCustomizeController.backgroundColorSelectedIndex.value);
    return Container(
      color: Colors.white,
      child: Column(
          children: [
            // preview field
            Obx(() => Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text('Đây là bản xem trước',
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
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40,),
            Expanded(
              child: ListView(
                children: [
                  TextCustomOption(
                    currentValue: textCustomizeController.currentFontSize.value,
                    option: 'Cỡ chữ', step: 1, max: 50, min: 10,
                    onChanged: (double value) {
                      textCustomizeController.saveToDb('fontSize', value);
                      textCustomizeController.currentFontSize.value = value;
                      print(textCustomizeController.currentFontSize.value);
                    },
                  ),
                  Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Kiểu chữ', style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                  ),
                  Container(
                    height: 200,
                    color: Colors.grey.shade200,
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                textCustomizeController.fontFamilySelectedIndex.value = index;
                                textCustomizeController.currentFontStyle.value = textCustomizeController.fontFamilyList[index];
                                textCustomizeController.saveToDb('fontFamily', textCustomizeController.currentFontStyle.value);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(() => Text(textCustomizeController.fontFamilyList[index],
                                  style: TextStyle(
                                      fontFamily: textCustomizeController.fontFamilyList[index],
                                      color: textCustomizeController.fontFamilySelectedIndex.value == index ? Colors.red : Colors.black,
                                      fontWeight: textCustomizeController.fontFamilySelectedIndex.value == index ? FontWeight.bold : FontWeight.normal
                                  ),
                                ),
                                )
                              )
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(thickness: 2.0,);
                        },
                        itemCount: textCustomizeController.fontFamilyList.length),
                  ),
                  Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Màu nền', style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40,),
                  Container(
                      height: orientation == Orientation.portrait ? 50 : 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                textCustomizeController.backgroundColorSelectedIndex.value = index;
                                textCustomizeController.currentBackgroundColor.value = 
                                    textCustomizeController.backgroundColor_text[index];
                                textCustomizeController.saveToDb('backgroundColor', textCustomizeController.backgroundColor_text[index]);
                              },
                              child: Obx(() => BackgroundOption(color: textCustomizeController.backgroundColor[index], isSelected: textCustomizeController.backgroundColorSelectedIndex.value == index,))
                          );
                        },
                        itemCount: textCustomizeController.backgroundColor.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10,);
                        },
                      )
                  ),
                  Divider(),

                  // text color options

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Màu chữ', style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40,),
                  Container(
                      height: orientation == Orientation.portrait ? 50 : 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                textCustomizeController.textColorSelectedIndex.value = index;
                                textCustomizeController.currentTextColor.value =
                                textCustomizeController.textColor_text[index];
                                textCustomizeController.saveToDb('textColor', textCustomizeController.textColor_text[index]);
                              },
                              child: Obx(() => BackgroundOption(color: textCustomizeController.textColor[index], isSelected: textCustomizeController.textColorSelectedIndex.value == index,))
                          );
                        },
                        itemCount: textCustomizeController.textColor.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10,);
                        },
                      )
                  ),
                  Divider(),

                  TextCustomOption(currentValue: textCustomizeController.currentCharacterSpacing.value,
                    option: 'Khoảng cách giữa các ký tự', step: 1, max: 10, min: 0,
                    onChanged: (double value) {
                      textCustomizeController.currentCharacterSpacing.value = value;
                      textCustomizeController.saveToDb('letterSpacing', value);
                    },
                  ),
                  Divider(),
                  TextCustomOption(currentValue: textCustomizeController.currentLineSpacing.value,
                    option: 'Khoảng cách giữa các dòng', step: 0.1, max: 2, min: 1,
                    onChanged: (double value) {
                      textCustomizeController.currentLineSpacing.value = value;
                      textCustomizeController.saveToDb('lineSpacing', value);
                    },
                  ),
                  Divider(),
                  TextCustomOption(currentValue: textCustomizeController.currentWordSpacing.value,
                    option: 'Khoảng cách giữa các từ', step: 5, max: 30, min: 0,
                    onChanged: (double value) {
                      textCustomizeController.currentWordSpacing.value = value;
                      textCustomizeController.saveToDb('wordSpacing', value);
                    },
                  ),
                ],
              ),
            )





            // Row(
            //   children: [
            //     const Text('Màu chữ'),
            //     const SizedBox(width: 30,),
            //     Obx(() => DropdownButton<String>(
            //             value: textCustomizeController.currentTextColor.value,
            //             focusColor: Colors.white,
            //             items: textColorList.map<DropdownMenuItem<String>>((String value) {
            //               return DropdownMenuItem<String>(
            //                 value: value,
            //                 child: Text(value),
            //               );
            //             }).toList(),
            //             onChanged: (String? value) {
            //               textCustomizeController.currentTextColor.value = value!;
            //             },
            //           ),
            //           )
            //   ],
            // ),
            // Row(
            //   children: [
            //     const Text('Màu nền'),
            //     const SizedBox(width: 30,),
            //     Obx(() => DropdownButton<String>(
            //       value: textCustomizeController.currentBackgroundColor.value,
            //       focusColor: Colors.white,
            //       items: backgroundColorList.map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //       onChanged: (String? value) {
            //         textCustomizeController.currentBackgroundColor.value = value!;
            //       },
            //     ),
            //     )
            //   ],
            // ),

            // TextCustomOption(currentValue: 1, option: 'Khoảng cách giữa các từ', step: 0.1, max: 5, min: 0)
          ],
        ),

    );

  }
}

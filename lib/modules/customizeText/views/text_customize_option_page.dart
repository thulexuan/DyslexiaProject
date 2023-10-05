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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          children: [
            Obx(() => Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                    letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                    wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                ),

              ),
            ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView(
                children: [
                  TextCustomOption(
                    currentValue: textCustomizeController.currentFontSize.value,
                    option: 'Cỡ chữ', step: 1, max: 50, min: 10,
                    onChanged: (double value) {
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
                          return Text('font style');
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemCount: 10),
                  ),
                  Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Màu nền', style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return BackgroundOption(color: textCustomizeController.backgroundColor[index],);
                        },
                        itemCount: textCustomizeController.backgroundColor.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10,);
                        },
                      )
                  ),
                  Divider(),
                  TextCustomOption(currentValue: textCustomizeController.currentCharacterSpacing.value,
                    option: 'Khoảng cách giữa các ký tự', step: 0.1, max: 5, min: 1,
                    onChanged: (double value) {
                      textCustomizeController.currentCharacterSpacing.value = value;
                    },
                  ),
                  Divider(),
                  TextCustomOption(currentValue: 2,
                    option: 'Khoảng cách giữa các dòng', step: 0.1, max: 5, min: 1,
                    onChanged: (double value) {
                      //
                    },
                  ),
                  Divider(),
                  TextCustomOption(currentValue: textCustomizeController.currentWordSpacing.value,
                    option: 'Khoảng cách giữa các từ', step: 0.1, max: 5, min: 1,
                    onChanged: (double value) {
                      textCustomizeController.currentWordSpacing.value = value;
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

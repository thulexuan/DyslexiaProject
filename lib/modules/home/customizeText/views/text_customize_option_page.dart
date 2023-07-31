
import 'package:counter_slider/counter_slider.dart';
import 'package:dyslexia_project/modules/home/customizeText/controllers/text_customize_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TextCustomizeOptionPage extends StatefulWidget {
  const TextCustomizeOptionPage({Key? key}) : super(key: key);

  @override
  State<TextCustomizeOptionPage> createState() => _TextCustomizeOptionPageState();
}

class _TextCustomizeOptionPageState extends State<TextCustomizeOptionPage> {

  final textEditingController = TextEditingController();
  final textCustomizeController = Get.put(TextCustomizeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = "Đây là bản xem trước";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Obx(() => TextField(
            controller: textEditingController,
            style: TextStyle(
              fontSize: textCustomizeController.current_font_size.value.toDouble(),
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue, // Set your desired border color here
                  width: 2.0, // Set the border width
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)), // Set the border radius
              ),
            ),
          )
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              const Text('Font size'),
              SizedBox(width: 20,),
              Obx(() => CounterSlider(
                value: textCustomizeController.current_font_size.value,
                width: 120,
                height: 40,
                borderSize: 0.5,
                gapSize: 4,
                onChanged: (int value) {
                  textCustomizeController.current_font_size.value = value;
                },
              )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

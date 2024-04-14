import 'package:dyslexia_project/modules/common/views/overview_page.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:dyslexia_project/modules/readText/controllers/recognize_text_controller.dart';
import 'package:dyslexia_project/modules/readText/views/display_text_page.dart';
import 'package:dyslexia_project/modules/readText/views/listen_text_page.dart';
import 'package:dyslexia_project/modules/readText/views/read_options_page.dart';
import 'package:dyslexia_project/modules/readText/views/read_text_page.dart';
import 'package:dyslexia_project/modules/readText/views/read_with_support.dart';
import 'package:dyslexia_project/modules/readText/views/test_read_with_support.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DisplayPreviousText extends StatefulWidget {

   String readText;

   DisplayPreviousText({
     required this.readText
});

  @override
  State<DisplayPreviousText> createState() => _DisplayPreviousTextState();
}

class _DisplayPreviousTextState extends State<DisplayPreviousText> {

  TextEditingController textController = TextEditingController();
  final controller = Get.put(RecognizedTextController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = widget.readText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ảnh được chọn', style: Theme.of(context).textTheme.labelSmall,),
          toolbarHeight: MediaQuery.of(context).size.height / 12),
      body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: textController,
                          maxLines: null,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.to(ReadTextPage(text: textController.text,));
                    },
                    child: Text('Đọc văn bản', style: Theme.of(context).textTheme.labelSmall,)
                ),

                ElevatedButton(
                    onPressed: () {
                      Get.to(ListenTextPage(text: textController.text,));
                    },
                    child: Text('Nghe văn bản', style: Theme.of(context).textTheme.labelSmall,)
                ),

                ElevatedButton(
                    onPressed: () {
                      Get.to(Test(text: textController.text,));
                    },
                    child: Text('Đọc đoạn', style: Theme.of(context).textTheme.labelSmall,)
                ),
              ],
            )
          ],
        ),
    );

  }
}

import 'package:dyslexia_project/modules/common/controllers/custom_textediting_controller.dart';
import 'package:dyslexia_project/modules/common/views/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../customizeText/controllers/text_customize_controller.dart';
import '../../customizeText/views/customize_option_page.dart';

class ReadTextPage extends StatefulWidget {

  @override
  State<ReadTextPage> createState() => _ReadTextPageState();

  final String text;

  ReadTextPage({
    required this.text,
  });
}

class _ReadTextPageState extends State<ReadTextPage> with SingleTickerProviderStateMixin{

  final textCustomizeController = Get.put(TextCustomizeController());
  CustomEditingController customTextEditingController = CustomEditingController();

  @override
  void initState() {
    super.initState();
    customTextEditingController.text = widget.text;
    textCustomizeController.getData();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Đọc văn bản', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(OverviewPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.home, color: Colors.blue,),
                        Text('Về trang chủ', style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  )
              ),
              PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const CustomizeOptionPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.tune, color: Colors.blue,),
                        SizedBox(width: 20,),
                        Text('Tùy chỉnh', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  )
              ),
            ];
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => Container(
              color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  readOnly: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none
                  ),
                  maxLines: null,
                  controller: customTextEditingController,
                  style: TextStyle(
                      color: textCustomizeController.currentTextColor.value == 'black' ? Colors.black.withOpacity(textCustomizeController.currentOpacity.value)
                          : textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
                      fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                      fontFamily: textCustomizeController.currentFontStyle.value,
                      letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                      wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                      height: textCustomizeController.currentLineSpacing.value.toDouble()
                  ),
                ),
              ),
            ),
            )
          ],
        ),
      ),
    );
  }

}

import 'dart:io';
import 'package:dyslexia_project/data/word_image_mapping.dart';
import 'package:dyslexia_project/modules/readText/views/read_options_page.dart';
import 'package:dyslexia_project/overview_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../customizeText/controllers/sound_controller.dart';
import '../../customizeText/controllers/text_customize_controller.dart';
import '../../customizeText/views/customize_option_page.dart';
import '../controllers/recognize_text_controller.dart';

class DisplayTextPage extends StatefulWidget {

  @override
  State<DisplayTextPage> createState() => _DisplayTextPageState();

  final String text;

  DisplayTextPage({
    required this.text
});
}

class _DisplayTextPageState extends State<DisplayTextPage>
    with SingleTickerProviderStateMixin{
  final controller = Get.put(RecognizedTextController());
  final textCustomizeController = Get.put(TextCustomizeController());
  final soundCustomizeController = Get.put(SoundController());
  final textEditingController = TextEditingController();
  late TabController _tabController;

  bool isPause = true;

  FlutterTts flutterTts = FlutterTts();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = controller.extractedText.value;
    _tabController = TabController(length: 2, vsync: this);
    // textCustomizeController.getData();
  }

  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _showDialog(BuildContext context, String? imageUrl, String word) {
    Navigator.of(context).push(
      DialogRoute<void>(
        context: context,
        builder: (BuildContext context) =>
            Dialog(
                child: imageUrl != null ? Container(
                  height: 300,
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 200,
                          child: Image.asset(imageUrl!)
                      ),
                      Text(word),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.volume_up),
                      )
                    ],
                  ),
                ) : Container(
                    width: 100,
                    height: 200,
                    child: Image.asset('assets/images/no_image.png')
                ),
            )
      ),
    );
  }

  // Widget getTextWidgets(List<dynamic> strings)
  // {
  //   List<Widget> list = <Widget>[];
  //   for(var i = 0; i < strings.length; i++){
  //     list.add(new EachWord(word: strings[i], image_url: '',));
  //   }
  //   return new Container(child: Wrap(children: list,),);
  // }

  @override
  Widget build(BuildContext context) {

    print(textCustomizeController.currentFontSize.value);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Đọc văn bản'),),
      body: Column(
        children: [
          Obx(() =>
              controller.extractedText.value.isEmpty?
              const Center(child: Text("Text Not Found")):
              Container(
                height: MediaQuery.of(context).size.height - 220,
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
                child: Column(
                  children: [
                    Container(
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.teal,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.teal,
                        tabs: const [
                          Tab(child: Text('Văn bản',
                            style: TextStyle(fontSize: 18,),)
                          ),
                          Tab(child: Text('Ảnh',
                            style: TextStyle(fontSize: 18,),),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      // width: double.maxFinite,
                      // height: MediaQuery.of(context).size.height - 170,
                      child: TabBarView(
                        controller: _tabController,
                        children:  [
                          SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
                              child: TextField(
                                controller: textEditingController,
                                maxLines: null,
                                contextMenuBuilder: (BuildContext context,
                                    EditableTextState editableTextState) {

                                  final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
                                  final TextEditingValue value = textEditingController.value;
                                  buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                                    return buttonItem.type == ContextMenuButtonType.cut;
                                  });
                                  buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                                    return buttonItem.type == ContextMenuButtonType.copy;
                                  });
                                  buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                                    return buttonItem.type == ContextMenuButtonType.selectAll;
                                  });
                                  buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                                    return buttonItem.type == ContextMenuButtonType.paste;
                                  });
                                  buttonItems.insert(0,
                                    ContextMenuButtonItem(
                                      label: 'Ảnh',
                                      onPressed: () async {
                                        ContextMenuController.removeAny();
                                        String? imageUrl;
                                        if (wordImageMapping.containsKey(value.selection.textInside(value.text))) {
                                          imageUrl = wordImageMapping["${value.selection.textInside(value.text)}"];
                                        }
                                        _showDialog(
                                          context, imageUrl, value.selection.textInside(value.text)
                                        );
                                        print(value.selection.textInside(value.text));
                                        print(imageUrl);
                                      },
                                    ),
                                  );

                                  return AdaptiveTextSelectionToolbar.buttonItems(
                                    anchors: editableTextState.contextMenuAnchors,
                                    buttonItems: buttonItems,
                                  );
                                },
                                style: TextStyle(
                                    fontSize: textCustomizeController.currentFontSize.value.toDouble(),
                                    letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
                                    wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
                                    height: textCustomizeController.currentLineSpacing.value.toDouble()
                                ),
                              ),
                            ),
                          ),
                          controller.selectedImagePath.value==''?
                          const Center(child: Text("Select an image from Gallery / camera")):
                          Image.file(
                            File(controller.selectedImagePath.value),
                            width: Get.width,
                            //height: 400,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
          ),
          const SizedBox(height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.speak(controller.words.value);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.headphones,),
                      const Text('Nghe văn bản'),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(const CustomizeOptionPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.tune,),
                        const Text('Tùy chỉnh'),
                      ],
                    ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const OverviewPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.home,),
                      Text('Về trang chủ'),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const ReadOptions());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.image,),
                      Text('Chọn lại ảnh'),
                    ],
                  ),
                ),
              )
            ],
          )

          // Container(
          //   margin: EdgeInsets.all(15),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       IconButton(
          //           icon: Icon(Icons.camera_alt_sharp),
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) =>  ReadOptions()),
          //           );
          //         },
          //       ),
          //       IconButton(
          //           icon: isPause ? Icon(Icons.play_circle) : Icon(Icons.pause),
          //           onPressed: () {
          //             setState(() {
          //               isPause = !isPause;
          //             });
          //             isPause ? TextToSpeech().pause() : TextToSpeech().speakNormal(textEditingController.text,
          //                 soundCustomizeController.current_volume.value,
          //                 soundCustomizeController.current_rate.value,
          //                 soundCustomizeController.current_pitch.value);
          //           }
          //       ),
          //       IconButton(
          //           onPressed: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (context) =>  CustomizeOptionPage()),
          //             );
          //           },
          //           icon: Icon(Icons.toc),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );


    // return Scaffold(
    //   appBar: AppBar(title: Text('Đọc văn bản'),),
    //   body: Column(
    //     children: [
    //
    //       Container(
    //         height: MediaQuery.of(context).size.height - 250,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.grey.withOpacity(0.7),
    //               spreadRadius: 5,
    //               blurRadius: 7,
    //               offset: Offset(0, 3), // changes position of shadow
    //             ),
    //           ],
    //         ),
    //         child: SingleChildScrollView(
    //           child: selectedIndex == 0 ? Padding(
    //             padding: const EdgeInsets.all(10.0),
    //             child: TextField(
    //               controller: textEditingController,
    //               maxLines: null,
    //             ),
    //           ) : Image.file(
    //             File(controller.selectedImagePath.value),
    //             width: Get.width,
    //           ),
    //         ),
    //       ),
    //       // choose between image or text
    //       Container(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             ElevatedButton(
    //                 onPressed: () => onTap(0),
    //                 child: Text('Text')
    //             ),
    //             SizedBox(width: 10,),
    //             ElevatedButton(
    //                 onPressed: () => onTap(1),
    //                 child: Text('Image')
    //             ),
    //           ],
    //         ),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           TextButton(
    //             onPressed: () {  },
    //             child: Container(
    //               child: Row(
    //                 children: [
    //                   Icon(
    //                     Icons.headphones,
    //                   ),
    //                   Text(' Nghe văn bản')
    //                 ],
    //               ),
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () {  },
    //             child: Container(
    //               child: Row(
    //                 children: [
    //                   Icon(
    //                     Icons.tune,
    //                   ),
    //                   Text(' Tùy chỉnh')
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           TextButton(
    //             onPressed: () {  },
    //             child: Container(
    //               child: Row(
    //                 children: [
    //                   Icon(
    //                     Icons.home,
    //                   ),
    //                   Text(' Quay về trang chủ')
    //                 ],
    //               ),
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () {  },
    //             child: Container(
    //               child: Row(
    //                 children: [
    //                   Icon(
    //                     Icons.image,
    //                   ),
    //                   Text(' Chọn lại ảnh')
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}

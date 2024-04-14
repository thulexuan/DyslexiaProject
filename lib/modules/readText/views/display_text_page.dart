import 'dart:io';
import 'package:dyslexia_project/common_widgets/custom_text_selection_widget.dart';
import 'package:dyslexia_project/data/word_image_mapping.dart';
import 'package:dyslexia_project/modules/common/controllers/custom_textediting_controller.dart';
import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:dyslexia_project/modules/readText/views/read_options_page.dart';
import 'package:dyslexia_project/modules/common/views/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:styled_text/styled_text.dart';
import 'package:styled_text/tags/styled_text_tag.dart';

import '../../../common_widgets/custom_switch.dart';
import '../../customizeText/controllers/text_customize_controller.dart';
import '../../customizeText/views/customize_option_page.dart';
import '../controllers/recognize_text_controller.dart';

class DisplayTextPage extends StatefulWidget {

  @override
  State<DisplayTextPage> createState() => _DisplayTextPageState();

  final String text;

  DisplayTextPage({
    required this.text,
});
}

class _DisplayTextPageState extends State<DisplayTextPage> with SingleTickerProviderStateMixin{
  final controller = Get.put(RecognizedTextController());
  final textCustomizeController = Get.put(TextCustomizeController());
  CustomEditingController customTextEditingController = CustomEditingController();
  late TabController _tabController;

  bool isPause = true;


  FlutterTts flutterTts = FlutterTts();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // customTextEditingController.text = controller.extractedText.value;
    customTextEditingController.text = widget.text;
    _tabController = TabController(length: 2, vsync: this);
    textCustomizeController.getData();

  }

  int selectedIndex = 0;

  bool highlightMirrorLetterOption = true;
  bool showImageOption = false;
  bool canEdit = true;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Đọc văn bản', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Text('Highlight chữ gương', ),
                      StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Switch(
                          value: highlightMirrorLetterOption,
                          onChanged: (newValue) {
                            setState(() {
                              highlightMirrorLetterOption = newValue;
                              customTextEditingController.highlightMirrorLetterOption = newValue;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Text('Hiển thị hình ảnh',),
                      StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Switch(
                          value: showImageOption,
                          onChanged: (newValue) {
                            setState(() {
                              showImageOption = newValue;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Text('Sửa văn bản', ),
                      CustomSwitch(
                        value: canEdit,
                        onChanged: (newValue) {
                          setState(() {
                            canEdit = newValue;
                          });
                        },
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                    child: GestureDetector(
                      onTap: () async {
                        print('start listening');
                        SoundFunction().speakFast(
                            customTextEditingController.text,
                            textCustomizeController.current_volume.value,
                            textCustomizeController.current_rate.value,
                            textCustomizeController.current_pitch.value,
                            textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
                          customTextEditingController.text.split(' '),
                          0
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.headphones, color: Colors.blue,),
                          SizedBox(width: 20,),
                          Text('Nghe văn bản',),
                        ],
                      ),
                    ),
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () async {
                      SoundFunction().speak(
                          customTextEditingController.text,
                          textCustomizeController.current_volume.value,
                          textCustomizeController.current_rate.value,
                          textCustomizeController.current_pitch.value,
                          textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
                          customTextEditingController.text.split(' '),
                          0
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.headphones, color: Colors.blue,),
                        SizedBox(width: 20,),
                        Text('Nghe chậm',),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const CustomizeOptionPage());
                      },
                        child: Row(
                          children: const [
                            Icon(Icons.tune, color: Colors.blue,),
                            SizedBox(width: 20,),
                            Text('Tùy chỉnh',),
                          ],
                        ),
                    )
                ),
                PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const OverviewPage());                      },
                      child: Row(
                        children: const [
                          Icon(Icons.home, color: Colors.blue,),
                          SizedBox(width: 20,),
                          Text('Về trang chủ',),
                        ],
                      ),
                    )
                ),
                PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const ReadOptions());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.image, color: Colors.blue,),
                          SizedBox(width: 20,),
                          Text('Chọn lại ảnh',),
                        ],
                      ),
                    )
                )
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() =>
                controller.extractedText.value.isEmpty?
                Center(child: Text("Không đọc được văn bản", style: Theme.of(context).textTheme.bodyMedium,)) :
                Container(
                  height: MediaQuery.of(context).size.height,
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
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
                      // child: StyledText.selectable(
                      //   text: controller.extractedText.value,
                      //   newLineAsBreaks: true,
                      //     contextMenuBuilder: (BuildContext context,
                      //         EditableTextState editableTextState) {
                      //
                      //       final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
                      //       final TextEditingValue value = customTextEditingController.value;
                      //       buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                      //         return buttonItem.type == ContextMenuButtonType.cut;
                      //       });
                      //       buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                      //         return buttonItem.type == ContextMenuButtonType.copy;
                      //       });
                      //       buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                      //         return buttonItem.type == ContextMenuButtonType.selectAll;
                      //       });
                      //       buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                      //         return buttonItem.type == ContextMenuButtonType.paste;
                      //       });
                      //       showImageOption ? buttonItems.insert(0,
                      //         ContextMenuButtonItem(
                      //           label: 'Ảnh',
                      //           onPressed: () async {
                      //             ContextMenuController.removeAny();
                      //             String? imageUrl;
                      //             if (wordImageMapping.containsKey(value.selection.textInside(value.text))) {
                      //               imageUrl = wordImageMapping["${value.selection.textInside(value.text)}"];
                      //             }
                      //             _showDialog(
                      //                 context, imageUrl, value.selection.textInside(value.text)
                      //             );
                      //             print(value.selection.textInside(value.text));
                      //             print(imageUrl);
                      //           },
                      //         ),
                      //       ) : buttonItems.addAll([
                      //         ContextMenuButtonItem(label: 'In đậm', onPressed: () {
                      //           final String selectedText = value.text.substring(value.selection.start, value.selection.end);
                      //
                      //
                      //
                      //         }),
                      //         // ContextMenuButtonItem(label: '+', onPressed: () {}),
                      //         // ContextMenuButtonItem(label: '-', onPressed: () {})
                      //         ]
                      //       );
                      //
                      //       return AdaptiveTextSelectionToolbar.buttonItems(
                      //         anchors: editableTextState.contextMenuAnchors,
                      //         buttonItems: buttonItems,
                      //       );
                      //     },
                      // ),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                        controller: customTextEditingController,
                        maxLines: null,
                        readOnly: !canEdit,
                        // tap to word for understanding its meaning
                        contextMenuBuilder: (BuildContext context,
                            EditableTextState editableTextState) {

                          final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
                          final TextEditingValue value = customTextEditingController.value;
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
                          showImageOption ? buttonItems.addAll([
                            ContextMenuButtonItem(
                              label: 'Ảnh',
                              onPressed: () async {
                                // ContextMenuController.removeAny();
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
                            ContextMenuButtonItem(
                              label: 'Nghe',
                              onPressed: () async {
                                SoundFunction().speakFast(
                                    value.selection.textInside(value.text),
                                    textCustomizeController.current_volume.value,
                                    textCustomizeController.current_rate.value,
                                    textCustomizeController.current_pitch.value,
                                    textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
                                    customTextEditingController.text.split(' '),
                                    0
                                );
                              },
                            ),
                          ],
                          )
                              : buttonItems.addAll([
                            // ContextMenuButtonItem(label: 'In đậm', onPressed: () {
                            //   final String selectedText = value.text.substring(value.selection.start, value.selection.end);
                            //   final TextSpan styledSpan = _stylizeWord(selectedText);
                            //
                            // }),
                            // ContextMenuButtonItem(label: '+', onPressed: () {}),
                            // ContextMenuButtonItem(label: '-', onPressed: () {})
                          ]
                          );

                          return AdaptiveTextSelectionToolbar.buttonItems(
                            anchors: editableTextState.contextMenuAnchors,
                            buttonItems: buttonItems,
                          );
                        },
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
                  // child: Column(
                  //   children: [
                  //     Container(
                  //       child: TabBar(
                  //         controller: _tabController,
                  //         labelColor: Colors.teal,
                  //         unselectedLabelColor: Colors.black,
                  //         indicatorColor: Colors.teal,
                  //         tabs: [
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Tab(child: Text('Văn bản',
                  //               style: Theme.of(context).textTheme.bodyMedium,)
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Tab(child: Text('Ảnh',
                  //               style: Theme.of(context).textTheme.bodyMedium,),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       // width: double.maxFinite,
                  //       // height: MediaQuery.of(context).size.height - 170,
                  //       child: TabBarView(
                  //         controller: _tabController,
                  //         children:  [
                  //           // display text
                  //
                  //
                  //           // display image
                  //           controller.selectedImagePath.value==''?
                  //           const Center(child: Text("Chụp ảnh hoặc chọn ảnh từ thư viện ảnh")):
                  //           Image.file(
                  //             File(controller.selectedImagePath.value),
                  //             width: Get.width,
                  //             //height: 400,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // )
                )
            ),
            const SizedBox(height: 20,
            ),

          ],
        ),
      ),
    );
  }

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
                child: Container(
                  height: 600,
                  width: 600,
                  child: Column(
                    children: [
                      Container(
                          width: 400,
                          height: 400,
                          child: imageUrl != null ? Image.asset(imageUrl!) : Image.asset('assets/images/no_image.png')
                      ),
                      Text(word, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
                      SizedBox(height: 20,),
                      IconButton(
                        onPressed: () {
                          SoundFunction().speakFast(
                              word,
                              textCustomizeController.current_volume.value,
                              textCustomizeController.current_rate.value,
                              textCustomizeController.current_pitch.value,
                              textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
                              word.split(' '),
                            0
                          );
                        },
                        icon: Icon(Icons.volume_up, size: Theme.of(context).iconTheme.size,),
                      )
                    ],
                  ),
                )
              )
      ),
    );
  }

  TextSpan _stylizeWord(String word) {
    return TextSpan(
      text: word,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    );
  }

}

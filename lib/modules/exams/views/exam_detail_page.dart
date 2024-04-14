// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dyslexia_project/models/doneProcess.dart';
// import 'package:dyslexia_project/models/doneExam.dart';
// import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
// import 'package:dyslexia_project/modules/exams/controllers/each_exam_controller.dart';
// import 'package:dyslexia_project/modules/exams/views/component/oneQuestionItem.dart';
// import 'package:dyslexia_project/modules/exams/views/result_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../common_widgets/custom_switch.dart';
// import '../../../data/word_image_mapping.dart';
// import '../../common/controllers/custom_textediting_controller.dart';
// import '../../common/controllers/sound.dart';
// import '../../common/controllers/user_controller.dart';
// import '../../customizeText/views/customize_option_page.dart';
//
// class ExamDetailPage extends StatefulWidget {
//
//   String examCode;
//
//   ExamDetailPage({
//     required this.examCode,
// });
//
//   @override
//   State<ExamDetailPage> createState() => _ExamDetailPageState();
// }
//
// class _ExamDetailPageState extends State<ExamDetailPage> {
//
//   final PageController controller = PageController();
//   final each_exam_controller = Get.put(EachExamController());
//   final userController = Get.put(UserController());
//   final textCustomizeController = Get.put(TextCustomizeController());
//   CustomEditingController customTextEditing = CustomEditingController();
//
//   List<dynamic> listQuestions = [];
//
//
//
//
//   String long_text = '';
//   bool highlightMirrorLetterOption = true;
//   bool canEdit = false;
//   bool showImageOption = false;
//
//
//   Future<void> getExamDetail(String examCode) async {
//     final QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('examCollection').where('examCode', isEqualTo: examCode).get();
//
//     // get data from the first document in the snapshot
//     final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};
//
//     setState(() {
//       long_text =  data != null && data is Map<String, dynamic> ? data['text'] : 'no text' ;
//       listQuestions = data != null && data is Map<String, dynamic> ? data['questions'] : [];
//     });
//
//
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     each_exam_controller.getExamDetail(widget.examCode);
//     // getDoneExams();
//     getExamDetail(widget.examCode);
//     textCustomizeController.getData();
//     customTextEditing.text = long_text;
//   }
//   @override
//   Widget build(BuildContext context) {
//     customTextEditing.text = long_text;
//     return Scaffold(
//       appBar: AppBar(title: Text('Bài kiểm tra mã ' + (widget.examCode).toString(), style: Theme.of(context).textTheme.labelSmall,),
//         toolbarHeight: MediaQuery.of(context).size.height / 12,
//         actions: [
//           PopupMenuButton(
//             itemBuilder: (BuildContext context) {
//               return [
//                 PopupMenuItem(
//                   child: Row(
//                     children: [
//                       Text('Highlight chữ gương', ),
//                       StatefulBuilder(builder:
//                           (BuildContext context, StateSetter setState) {
//                         return Switch(
//                           value: highlightMirrorLetterOption,
//                           onChanged: (newValue) {
//                             setState(() {
//                               highlightMirrorLetterOption = newValue;
//                               customTextEditing.highlightMirrorLetterOption = newValue;
//                             });
//                           },
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//                 PopupMenuItem(
//                   child: Row(
//                     children: [
//                       Text('Hiển thị hình ảnh',),
//                       StatefulBuilder(builder:
//                           (BuildContext context, StateSetter setState) {
//                         return Switch(
//                           value: showImageOption,
//                           onChanged: (newValue) {
//                             setState(() {
//                               showImageOption = newValue;
//                             });
//                           },
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//                 PopupMenuItem(
//                   child: Row(
//                     children: [
//                       Text('Sửa văn bản', ),
//                       CustomSwitch(
//                         value: canEdit,
//                         onChanged: (newValue) {
//                           setState(() {
//                             canEdit = newValue;
//                           });
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//                 PopupMenuItem(
//                   child: GestureDetector(
//                     onTap: () async {
//                       print('start listening');
//                       SoundFunction().speakFast(
//                           customTextEditing.text,
//                           textCustomizeController.current_volume.value,
//                           textCustomizeController.current_rate.value,
//                           textCustomizeController.current_pitch.value,
//                           textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
//                           customTextEditing.text.split(' '),
//                           0
//                       );
//                     },
//                     child: Row(
//                       children: const [
//                         Icon(Icons.headphones, color: Colors.blue,),
//                         SizedBox(width: 20,),
//                         Text('Nghe văn bản',),
//                       ],
//                     ),
//                   ),
//                 ),
//                 PopupMenuItem(
//                   child: GestureDetector(
//                     onTap: () async {
//                       SoundFunction().speak(
//                           customTextEditing.text,
//                           textCustomizeController.current_volume.value,
//                           textCustomizeController.current_rate.value,
//                           textCustomizeController.current_pitch.value,
//                           textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
//                           customTextEditing.text.split(' '),
//                           0
//                       );
//                     },
//                     child: Row(
//                       children: const [
//                         Icon(Icons.headphones, color: Colors.blue,),
//                         SizedBox(width: 20,),
//                         Text('Nghe chậm',),
//                       ],
//                     ),
//                   ),
//                 ),
//                 PopupMenuItem(
//                     child: GestureDetector(
//                       onTap: () {
//                         Get.to(const CustomizeOptionPage());
//                       },
//                       child: Row(
//                         children: const [
//                           Icon(Icons.tune, color: Colors.blue,),
//                           SizedBox(width: 20,),
//                           Text('Tùy chỉnh',),
//                         ],
//                       ),
//                     )
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       body: Row(
//         children: [
//
//           // Text is here
//
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Container(
//                 height: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       offset: Offset(0, 3), // Shadow position (x, y)
//                       blurRadius: 5, // Spread of the shadow
//                       spreadRadius: 2, // Extends the shadow
//                     ),
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                     child: Obx(() => Container(
//                         padding: const EdgeInsets.all(8.0),
//                         color: textCustomizeController.backgroundColor.elementAt(textCustomizeController.backgroundColor_text.indexOf(textCustomizeController.currentBackgroundColor.value)),
//                         child: TextField(
//                           readOnly: !canEdit,
//                           controller: customTextEditing,
//                           maxLines: null,
//                           // readOnly: !canEdit,
//                           decoration: const InputDecoration(
//                               border: InputBorder.none
//                           ),
//                           contextMenuBuilder: (BuildContext context,
//                               EditableTextState editableTextState) {
//
//                             final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
//                             final TextEditingValue value = customTextEditing.value;
//                             buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
//                               return buttonItem.type == ContextMenuButtonType.cut;
//                             });
//                             buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
//                               return buttonItem.type == ContextMenuButtonType.copy;
//                             });
//                             buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
//                               return buttonItem.type == ContextMenuButtonType.selectAll;
//                             });
//                             buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
//                               return buttonItem.type == ContextMenuButtonType.paste;
//                             });
//                             showImageOption ? buttonItems.addAll([
//                               ContextMenuButtonItem(
//                                 label: 'Ảnh',
//                                 onPressed: () async {
//                                   // ContextMenuController.removeAny();
//                                   String? imageUrl;
//                                   if (wordImageMapping.containsKey(value.selection.textInside(value.text))) {
//                                     imageUrl = wordImageMapping["${value.selection.textInside(value.text)}"];
//                                   }
//                                   _showDialog(
//                                       context, imageUrl, value.selection.textInside(value.text)
//                                   );
//                                   print(value.selection.textInside(value.text));
//                                   print(imageUrl);
//                                 },
//                               ),
//                               ContextMenuButtonItem(
//                                 label: 'Nghe',
//                                 onPressed: () async {
//                                   SoundFunction().speakFast(
//                                       value.selection.textInside(value.text),
//                                       textCustomizeController.current_volume.value,
//                                       textCustomizeController.current_rate.value,
//                                       textCustomizeController.current_pitch.value,
//                                       textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
//                                       customTextEditing.text.split(' '),
//                                       0
//                                   );
//                                 },
//                               ),
//                             ],
//                             )
//                                 : buttonItems.addAll([
//                             ]
//                             );
//
//                             return AdaptiveTextSelectionToolbar.buttonItems(
//                               anchors: editableTextState.contextMenuAnchors,
//                               buttonItems: buttonItems,
//                             );
//                           },
//                           style: TextStyle(
//                               color: textCustomizeController.textColor.elementAt(textCustomizeController.textColor_text.indexOf(textCustomizeController.currentTextColor.value)),
//                               fontSize: textCustomizeController.currentFontSize.value.toDouble(),
//                               fontFamily: textCustomizeController.currentFontStyle.value,
//                               letterSpacing: textCustomizeController.currentCharacterSpacing.value.toDouble(),
//                               wordSpacing: textCustomizeController.currentWordSpacing.value.toDouble(),
//                               height: textCustomizeController.currentLineSpacing.value.toDouble()
//                           ),
//                         )
//
//
//                     )
//                     )
//
//                 ),
//               ),
//             ),
//           ),
//
//           // questions here
//
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//               height: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//               ),
//               child: Container(
//                 height: MediaQuery.of(context).size.height,
//                 child: PageView.builder(
//                   controller: controller,
//                   itemCount: listQuestions.length,
//                   itemBuilder: (context, index) {
//                     return OneQuestionItem(questionNum: index, listQuestions: listQuestions, pageController: controller, examCode: widget.examCode,);
//                   },
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void _showDialog(BuildContext context, String? imageUrl, String word) {
//     Navigator.of(context).push(
//       DialogRoute<void>(
//           context: context,
//           builder: (BuildContext context) =>
//               Dialog(
//                   child: Container(
//                     height: 600,
//                     width: 600,
//                     child: Column(
//                       children: [
//                         Container(
//                             width: 400,
//                             height: 400,
//                             child: imageUrl != null ? Image.asset(imageUrl!) : Image.asset('assets/images/no_image.png')
//                         ),
//                         Text(word, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
//                         SizedBox(height: 20,),
//                         IconButton(
//                           onPressed: () {
//                             SoundFunction().speakFast(
//                                 word,
//                                 textCustomizeController.current_volume.value,
//                                 textCustomizeController.current_rate.value,
//                                 textCustomizeController.current_pitch.value,
//                                 textCustomizeController.voiceNameCodeList[textCustomizeController.voiceSelectedIndex.value],
//                                 word.split(' '),
//                                 0
//                             );
//                           },
//                           icon: Icon(Icons.volume_up, size: Theme.of(context).iconTheme.size,),
//                         )
//                       ],
//                     ),
//                   )
//               )
//       ),
//     );
//   }
//
//   Future<void> nextPage() async {
//     if (controller.page?.toInt() == each_exam_controller.listQuestions.length - 1) {
//       await each_exam_controller.resultProcess();
//
//
//       // add exam nay done vao user
//
//
//
//       // chuyển trang
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ResultPage(totalQues: each_exam_controller.listQuestions.length, numCorrectAns: each_exam_controller.numOfCorrect.value,)),
//       );
//     } else {
//       controller.nextPage(
//           duration: Duration(milliseconds: 400),
//           curve: Curves.easeIn
//       );
//     }
//   }
//
// }
//

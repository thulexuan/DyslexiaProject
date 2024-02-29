import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/models/exam.dart';
import 'package:dyslexia_project/models/question.dart';
import 'package:dyslexia_project/modules/teacher_role/createExam/view_created_exam.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CreateExamPage extends StatefulWidget {
  @override
  State<CreateExamPage> createState() => _CreateExamPageState();
}

class _CreateExamPageState extends State<CreateExamPage> {

  var fileContent = '';
  var examCode = '';
  var authorName = '';
  var isCreated = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Tạo bài kiểm tra', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 60,),
            ElevatedButton(
                onPressed: () {
                  pickAndDisplayContent();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Chọn file', style: Theme.of(context).textTheme.labelSmall,),
                )
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Nội dung file', style: Theme.of(context).textTheme.bodyLarge,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height / 2 : MediaQuery.of(context).size.height / 2.5,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                        controller: controller,
                        maxLines: null,
                        style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  createExam(controller.text);
                  isCreated = true;
                },
                child: Text('Tạo bài kiểm tra', style: Theme.of(context).textTheme.labelSmall,)
            ),
            isCreated ? ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewCreatedExam(examCode: examCode,)),
                  );
                  print(examCode);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Xem bài kiểm tra được tạo', style: Theme.of(context).textTheme.labelSmall),
                )
            ) : const Text(''),

          ],
        ),
      ),
    );
  }

  Future<void> pickAndDisplayContent() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      );

      if (result != null) {
        // Handle the picked file
        PlatformFile file = result.files.first;

        // Analyze the content (replace with your specific analysis logic)
        String content = await readContentFromFile(file.path!);
        setState(() {
          fileContent = content;
          controller.text = content;
        });

        print(content);


      } else {
        // User canceled the picker
        print('User canceled');
      }
    } catch (e) {
      print('Error picking and analyzing document: $e');
    }
  }

  Future<String> readContentFromFile(String filePath) async {
    try {
      File file = File(filePath);
      String content = await file.readAsString();
      return content;
    } catch (e) {
      print('Error reading file: $e');
      return '';
    }
  }

  Future<void> createExam(String content) async {
    List<String> lines = content.split('\n');
    setState(() {
      examCode = lines[0];
    });
    String text = '';
    int marker = 1;
    for (var i=1;i<lines.length;i++) {
      if (lines[i].startsWith("Trả lời câu hỏi sau:")) {
        marker = i;
        break;
      } else {
        text += lines[i];
      }
    }

    // get list of questions
    List<Map<String, dynamic>> questionsOfExam = [];

    for (var i = marker + 1; i < lines.length - 4; i++) {
      String questionDetail = lines[i];
      List<String> options = [];
      options.add(lines[i+1]);
      options.add(lines[i+2]);
      options.add(lines[i+3]);
      int answer = -1;
      if (lines[i+4].startsWith('A')) answer = 0;
      if (lines[i+4].startsWith('B')) answer = 1;
      if (lines[i+4].startsWith('C')) answer = 2;

      questionsOfExam.add({
        'questionsDetail' : questionDetail,
        'options' : options,
        'answer' : answer
      });

      i+= 4;
    }

    // save to database

    List<Map<String, dynamic>> questions = [];

    for (var question in questionsOfExam) {
      Question q = Question(answer: question['answer'], options: question['options'], questionDetail: question['questionsDetail']);
      Map<String, dynamic> qMap = q.toJson();
      questions.add(qMap);
    }

    // add examCode to examCreated of user
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: prefs.getString('email')).get();

    final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};
    var examCreated = data != null && data is Map<String, dynamic> ? data['examCreated'] : [];
    if (!examCreated.contains(examCode)) {
      examCreated.add(examCode);
    }

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs[0].reference.update({
        "examCreated" : examCreated
      });
    }

    // get authorName
    setState(() {
      authorName = data != null && data is Map<String, dynamic> ? data['fullname'] : '';
    });

    // create exam to save to db

    Exam exam = Exam(questions: questions, text: text, totalQues: questionsOfExam.length, authorName: authorName, examCode: examCode);

    CollectionReference examCollection = FirebaseFirestore.instance.collection('examCollection');

    Map<String, dynamic> examMap = exam.toJson();

    // check if examCode exists. If exist -> update else add to db
    // get list of examCode
    QuerySnapshot exams = await FirebaseFirestore.instance.collection('examCollection').get();
    var examCodeList = [];

    for (QueryDocumentSnapshot exam in exams.docs) {
      Map<String, dynamic> data = exam.data() as Map<String, dynamic>;
      examCodeList.add(data['examCode']);
    }

    print(examCodeList);

    // check if examCode is in examCodeList

    if (examCodeList.contains(examCode)) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('examCollection')
          .where("examCode", isEqualTo: examCode).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the first matching document
        DocumentReference documentReference = querySnapshot.docs.first.reference;
        // Delete the document
        await documentReference.delete();
        print('Document deleted successfully!');
      }
    }

    await examCollection.add(examMap);
    showDialogAddExam(context, examCode);
    print('add successfully');
  }

  Future<void> showDialogAddExam(BuildContext context, String examCode) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Thêm bài kiểm tra mã ${examCode} thành công'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Có'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'createExam/view_created_exam.dart';

class ViewAllCreatedExams extends StatefulWidget {
  const ViewAllCreatedExams({Key? key}) : super(key: key);

  @override
  State<ViewAllCreatedExams> createState() => _ViewAllCreatedExamsState();
}

class _ViewAllCreatedExamsState extends State<ViewAllCreatedExams> {
  List<dynamic> allExamsCreated = [];

  Future<void> getAllExamsCreated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',
        isEqualTo: prefs.getString('email')) // add your condition here
        .get();

    // get data from the first document in the snapshot
    final Object? data =
    snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    setState(() {
      allExamsCreated = data != null && data is Map<String, dynamic> ? data['examCreated'] : [];
    });

  }

  @override
  void initState() {
    super.initState();
    getAllExamsCreated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Các bài kiểm tra đã tạo', style: Theme.of(context).textTheme.labelSmall,),
      toolbarHeight: MediaQuery.of(context).size.height / 12,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              for (var examCode in allExamsCreated)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: GestureDetector(
                          child: Icon(Icons.launch, size: Theme.of(context).iconTheme.size),
                          onTap: () {
                            Get.to(ViewCreatedExam(examCode: examCode,));
                          },
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text('Bài ${examCode}', style: Theme.of(context).textTheme.bodyLarge,)
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: GestureDetector(
                          child: Icon(Icons.delete, size: Theme.of(context).iconTheme.size),
                          onTap: () {
                            showDialogDeleteExam(context, examCode);
                          },
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  deleteExam(String examCode) async {
    try {
      // delete examCode trong examCreated của user
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').where('email',
          isEqualTo: prefs.getString('email')).get();

      final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

      List<dynamic> examCreated = data != null && data is Map<String, dynamic> ? data['examCreated'] : [];

      examCreated.removeWhere((element) => element == examCode);

      print(examCreated);
      print(examCode);

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs[0].reference.update({
          "examCreated" : examCreated
        });
      }
      // delete exam có examCode trong examCollection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('examCollection')
          .where("examCode", isEqualTo: examCode).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the first matching document
        DocumentReference documentReference = querySnapshot.docs.first.reference;

        // Delete the document
        await documentReference.delete();
        print('Document deleted successfully!');
      } else {
        print('No document found with the specified field value.');
      }
      // delete kết quả làm bài có examCode đó của các user
      QuerySnapshot querySnapshotUsers = await FirebaseFirestore.instance.collection('users').get(); // get all users
      for (var querySnapshotUser in querySnapshotUsers.docs) { // for từng user
        // tất cả doneExams của mỗi user
        List<dynamic> doneExamsOfEachUser = List.from(querySnapshotUser['doneExams']);
        for (var doneExamOfEachUser in doneExamsOfEachUser.toList()) { // for từng doneExam của mỗi user
          if (doneExamOfEachUser is Map && doneExamOfEachUser['examCode'] == examCode) {
            doneExamsOfEachUser.remove(doneExamOfEachUser);
          }
        }
        // update lại user
        await querySnapshotUser.reference.update({
          'doneExams' : doneExamsOfEachUser
        });
      }
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> showDialogDeleteExam(BuildContext context, String examCode) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Bạn chắc chắn muốn xóa bài kiểm tra này?', style: Theme.of(context).textTheme.bodyMedium,),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text('Có', style: Theme.of(context).textTheme.bodySmall,),
                onPressed: () {
                  deleteExam(examCode);
                  setState(() {
                    allExamsCreated.removeWhere((element) => element == examCode);
                  });
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text('Không', style: Theme.of(context).textTheme.bodySmall),
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

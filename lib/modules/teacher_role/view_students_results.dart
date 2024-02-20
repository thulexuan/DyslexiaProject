import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/profile/do_exam_process.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ViewAllStudentsResults extends StatefulWidget {
  ViewAllStudentsResults({Key? key}) : super(key: key);

  @override
  State<ViewAllStudentsResults> createState() => _ViewAllStudentsResultsState();
}

class _ViewAllStudentsResultsState extends State<ViewAllStudentsResults> {
  List<dynamic> emailOfAllUsers = [];

  List<dynamic> fullnameOfAllUsers = [];

  Future<void> getAllUsers() async {
    // get all users that are students
    QuerySnapshot querySnapshotUsers = await FirebaseFirestore.instance.collection('users').get(); // get all users
    for (var querySnapshotUser in querySnapshotUsers.docs) {// for từng user
      if (querySnapshotUser['role'] == 'Học sinh') {
        setState(() {
          emailOfAllUsers.add(querySnapshotUser['email']);
          fullnameOfAllUsers.add(querySnapshotUser['fullname']);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Xem kết quả của học sinh'),),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Tên học sinh', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Kết quả', style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
            for (var i=0; i < emailOfAllUsers.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(fullnameOfAllUsers[i]),
                  TextButton(
                      onPressed: () {
                        Get.to(DoExamProcess(email: emailOfAllUsers.elementAt(i)));
                      },
                      child: Text('Xem')
                  )
                ],
              )

          ],
        ),
      ),
    );
  }
}

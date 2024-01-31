import 'package:dyslexia_project/modules/teacher_role/view_all_created_exam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/controllers/signin_controller.dart';
import '../auth/views/login.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final signInController = Get.put(SignInController());

  Future<void> showDialogSignOut(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Bạn muốn đăng xuất khỏi ứng dụng?'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Có'),
                onPressed: () {
                  signInController.signOut();
                  Get.to(Login());
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Không'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cài đặt'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.logout),
                const SizedBox(width: 30,),
                GestureDetector(
                    onTap: () => showDialogSignOut(context),
                    child: const Text('Đăng xuất')
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.book),
                const SizedBox(width: 30,),
                GestureDetector(
                    onTap: () {
                      Get.to(const ViewAllCreatedExams());
                    },
                    child: const Text('Các bài kiểm tra đã tạo')
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

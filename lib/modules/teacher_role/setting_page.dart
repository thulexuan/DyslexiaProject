import 'package:dyslexia_project/modules/teacher_role/create_image_page.dart';
import 'package:dyslexia_project/modules/teacher_role/view_all_created_exam.dart';
import 'package:dyslexia_project/modules/teacher_role/view_students_results.dart';
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
            content: Text('Bạn muốn đăng xuất khỏi ứng dụng?', style: Theme.of(context).textTheme.bodyMedium,),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text('Có', style: Theme.of(context).textTheme.bodySmall,),
                onPressed: () {
                  signInController.signOut();
                  Get.to(Login());
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text('Không', style: Theme.of(context).textTheme.bodySmall,),
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
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(title: Text('Cài đặt', style: Theme.of(context).textTheme.labelSmall,),
        toolbarHeight: MediaQuery.of(context).size.height / 12),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(Icons.logout, size: Theme.of(context).iconTheme.size,),
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
                Icon(Icons.book, size: Theme.of(context).iconTheme.size,),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(Icons.book, size: Theme.of(context).iconTheme.size,),
                const SizedBox(width: 30,),
                GestureDetector(
                    onTap: () {
                      Get.to( ViewAllStudentsResults());
                    },
                    child: const Text('Xem kết quả làm bài của học sinh')
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(Icons.image, size: Theme.of(context).iconTheme.size,),
                const SizedBox(width: 30,),
                GestureDetector(
                    onTap: () {
                      Get.to( CreateImagePage());
                    },
                    child: const Text('Tạo ảnh')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

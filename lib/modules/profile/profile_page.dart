import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/auth/controllers/signin_controller.dart';
import 'package:dyslexia_project/modules/auth/views/login.dart';
import 'package:dyslexia_project/modules/common/controllers/user_controller.dart';
import 'package:dyslexia_project/modules/profile/change_password_page.dart';
import 'package:dyslexia_project/modules/profile/do_exam_process.dart';
import 'package:dyslexia_project/modules/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
   ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final signInController = Get.put(SignInController());
  final userController = Get.put(UserController());


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
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Cài đặt'), automaticallyImplyLeading: false,),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 10,),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.teal,
                border: Border.all(
                  color: Colors.white
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('assets/images/avatar_default.png', fit: BoxFit.contain,),
              ),
            ),

            Obx(() => Text(userController.fullName.value)),
            Obx(() => Text(userController.email.value)),

            Divider(),

            ListTile(
              onTap: () {
                Get.to(EditProfilePage());
              },
              leading: const Icon(
                Icons.person,
                size: 25,
                color: Colors.blue,
              ),
              title: const Text(
                'Chỉnh sửa thông tin cá nhân',
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 25,
                color: Colors.blue,
              ),
            ),

            const Divider(),

            ListTile(
              onTap: () {
                Get.to(DoExamProcess());
              },
              leading: const Icon(
                Icons.school,
                size: 25,
                color: Colors.blue,
              ),
              title: const Text(
                'Bài kiểm tra đã làm',
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 25,
                color: Colors.blue,
              ),
            ),

            Divider(),

            ListTile(
              onTap: () {
                Get.to(ChangePasswordPage(email: userController.email.value,));
              },
              leading: const Icon(
                Icons.change_circle_outlined,
                size: 25,
                color: Colors.blue,
              ),
              title: const Text(
                'Đổi mật khẩu',
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 25,
                color: Colors.blue,
              ),
            ),

            const Divider(),

            ListTile(
              onTap: () => showDialogSignOut(context),
              leading: const Icon(
                Icons.logout,
                size: 25,
                color: Colors.blue,
              ),
              title: const Text(
                'Đăng xuất',
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 25,
                color: Colors.blue,
              ),
            ),

            const Divider()
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(title: Text('Cài đặt', style: Theme.of(context).textTheme.labelSmall,), automaticallyImplyLeading: false, toolbarHeight: MediaQuery.of(context).size.height / 12,),
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

            Obx(() => Text(userController.fullName.value, style: Theme.of(context).textTheme.bodyMedium)),
            Obx(() => Text(userController.email.value, style: Theme.of(context).textTheme.bodyMedium)),

            Divider(),

            ListTile(
              onTap: () {
                Get.to(EditProfilePage());
              },
              leading: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.width / 16,
                color: Colors.blue,
              ),
              title: Text(
                'Chỉnh sửa thông tin cá nhân',
                  style: Theme.of(context).textTheme.bodyMedium
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: MediaQuery.of(context).size.width / 16,
                color: Colors.blue,
              ),
            ),

            const Divider(),

            ListTile(
              onTap: () {
                Get.to(DoExamProcess(email: userController.email.value,));
              },
              leading: Icon(
                Icons.school,
                size: MediaQuery.of(context).size.width / 16,
                color: Colors.blue,
              ),
              title: Text(
                'Bài kiểm tra đã làm',
                  style: Theme.of(context).textTheme.bodyMedium
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: MediaQuery.of(context).size.width / 16,
                color: Colors.blue,
              ),
            ),

            Divider(),

            ListTile(
              onTap: () {
                Get.to(ChangePasswordPage(email: userController.email.value,));
              },
              leading: Icon(
                Icons.change_circle_outlined,
                size: MediaQuery.of(context).size.width / 16,
                color: Colors.blue,
              ),
              title: Text(
                'Đổi mật khẩu',
                  style: Theme.of(context).textTheme.bodyMedium
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: MediaQuery.of(context).size.width / 16,
                color: Colors.blue,
              ),
            ),

            const Divider(),

            ListTile(
              onTap: () => showDialogSignOut(context),
              leading: Icon(
                Icons.logout,
                size: MediaQuery.of(context).size.width / 16,
                color: Colors.blue,
              ),
              title: Text(
                'Đăng xuất',
                  style: Theme.of(context).textTheme.bodyMedium
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: MediaQuery.of(context).size.width / 16,
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

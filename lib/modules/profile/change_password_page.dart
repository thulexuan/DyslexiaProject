import 'package:dyslexia_project/modules/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {

  final email;

  ChangePasswordPage({
    required this.email,
});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  bool oldPasswordValid = true;
  bool newPasswordValid = true;
  String errorOnOldPassword = '';
  String errorOnNewPassword = '';

  checkOldPassword(email, oldPassword) async {
    String res = '';
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: oldPassword);
      res = "success";
    } catch (err) {
      res = err.toString();
    }

    if (res != "success") {
      setState(() {
        oldPasswordValid = false;
      });
    } else {
      setState(() {
        oldPasswordValid = true;
      });
    }
  }

  checkNewPasswordValid(String newPassword) {
    if (newPassword.isEmpty || newPassword.length < 6) {
      setState(() {
        newPasswordValid = false;
      });
    } else {
      setState(() {
        newPasswordValid = true;
      });
    }
  }

  changePassword(email, oldPassword, newPassword) async {
    await checkOldPassword(email, oldPassword);

    if (oldPasswordValid == false) {
      setState(() {
        errorOnOldPassword = 'Mật khẩu cũ không đúng';
      });
    }

    await checkNewPasswordValid(newPassword);

    if (newPasswordValid == false) {
      setState(() {
        errorOnNewPassword = 'Mật khẩu phải nhiều hơn 5 ký tự';
      });
    }

    if (oldPasswordValid == true && newPasswordValid == true) {
      var credential = EmailAuthProvider.credential(email: email, password: oldPassword);
      var currentUser = FirebaseAuth.instance.currentUser;

      try {
        await currentUser?.reauthenticateWithCredential(credential);
        await currentUser?.updatePassword(newPassword);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Đổi mật khẩu thành công. Hãy sử dụng mật khẩu mới cho những lần đăng nhập tiếp theo'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.to(ProfilePage());
                      },
                      child: Text('Okay')
                  )
                ],
              );
            }
        );
      } catch (error) {
        print(error.toString());
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Đổi mật khẩu'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Mật khẩu cũ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              TextField(
                controller: oldPasswordController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Nhập mật khẩu cũ",
                    errorText: oldPasswordValid ? null : errorOnOldPassword,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Mật khẩu mới', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),

              // fill password

              TextField(
                  controller: newPasswordController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Nhập mật khẩu mới",
                    errorText: newPasswordValid ? null : errorOnNewPassword,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),

                  )
              ),
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      changePassword(widget.email, oldPasswordController.text.trim(), newPasswordController.text.trim());
                      print(oldPasswordValid);
                      print(newPasswordValid);

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Đổi mật khẩu'),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
   ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

   Future passwordReset() async {
     try {
       await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
       showDialog(
           context: context,
           builder: (context) {
             return AlertDialog(
               content: Text('Gửi thành công. Vui lòng kiểm tra email để lấy lại mật khẩu'),
             );
           }
       );
     } on FirebaseAuthException catch (err) {
       print(err.toString());
       showDialog(
           context: context,
           builder: (context) {
             return AlertDialog(
               content: Text('Email không đúng. Vui lòng kiểm tra lại'),
             );
           }
       );
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Lấy lại mật khẩu'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/reset_password.png'),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Vui lòng điền địa chỉ email để tạo mật khẩu mới', style: TextStyle(fontSize: 20), textAlign: TextAlign.justify,),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: emailController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Nhập email",
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  passwordReset();
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Gửi', style: TextStyle(fontSize: 20),),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

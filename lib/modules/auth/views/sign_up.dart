import 'package:dyslexia_project/modules/auth/controllers/signin_controller.dart';
import 'package:dyslexia_project/modules/auth/controllers/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'login.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({Key? key}) : super(key: key);

  final signUpController = Get.put(SignUpController());
  final signinController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 35, right: 35),
            child: Column(
              children: [
                SizedBox(height: 180,),
                Center(
                  child: Text('Register', style: TextStyle(color: Colors.black, fontSize: 33),),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: signUpController.fullnameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Full name",
                      labelText: "Full name",
                      //errorText: authController.validEmail.value ? null : authController.errorEmail,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: signUpController.emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Email",
                      labelText: "Email",
                      //errorText: authController.validEmail.value ? null : authController.errorEmail,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: signUpController.passwordController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Password",
                      labelText: "Password",
                      //errorText: authController.validEmail.value ? null : authController.errorEmail,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: signUpController.confirmPasswordController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Confirm password",
                      labelText: "Confirm Password",
                      //errorText: authController.validEmail.value ? null : authController.errorEmail,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: signUpController.phoneNumberController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_android_outlined),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Phone number",
                      labelText: "Phone number",
                      //errorText: authController.validEmail.value ? null : authController.errorEmail,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => signUpController.signUp(context),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(color: Colors.blue)))),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        signinController.validEmail = true;
                        signinController.validPassword = true;
                        Get.to(() => Login());
                      },
                      child: Text('Đã có tài khoản'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Quên mật khẩu'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

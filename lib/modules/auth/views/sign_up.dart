import 'package:dyslexia_project/modules/auth/controllers/signin_controller.dart';
import 'package:dyslexia_project/modules/auth/controllers/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
   SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signUpController = Get.put(SignUpController());
  final signinController = Get.put(SignInController());
  late var isHiddenPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isHiddenPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(40, MediaQuery.of(context).size.height / 8, 40, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Đăng ký', style: TextStyle(color: Colors.black, fontSize: 33),),
                  ),
                  SizedBox(height: 10,),
                  // fullname field
                  Obx(() => TextField(
                    controller: signUpController.fullnameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Tên",
                        labelText: "Tên",
                        errorText: signUpController.fullNameError.value == '' ? null : signUpController.fullNameError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  ),

                  SizedBox(height: 10,),

                  // email field
                  Obx(() => TextField(
                    controller: signUpController.emailController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Email",
                        labelText: "Email",
                        errorText: signUpController.emailError.value == '' ? null : signUpController.emailError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  ),

                  SizedBox(height: 10,),

                  // password field
                  Obx(() => TextField(
                    controller: signUpController.passwordController,
                    style: TextStyle(color: Colors.black),
                    obscureText: isHiddenPassword ? true : false,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHiddenPassword = !isHiddenPassword;
                            });
                          },
                          child: isHiddenPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Mật khẩu",
                        labelText: "Mật khẩu",
                        errorText: signUpController.passwordError.value == '' ? null : signUpController.passwordError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  ),

                  SizedBox(height: 10,),

                  // confirm password field
                  Obx(() => TextField(
                    controller: signUpController.confirmPasswordController,
                    style: TextStyle(color: Colors.black),
                    obscureText: isHiddenPassword ? true : false,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHiddenPassword = !isHiddenPassword;
                            });
                          },
                          child: isHiddenPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Nhập lại mật khẩu",
                        labelText: "Nhập lại mật khẩu",
                        errorText: signUpController.confirmPasswordError.value == '' ? null : signUpController.confirmPasswordError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  ),

                  SizedBox(height: 10,),
                  Obx(() => TextField(
                    controller: signUpController.phoneNumberController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone_android_outlined),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Số điện thoại",
                        labelText: "Số điện thoại",
                        errorText: signUpController.phoneNumberError.value == '' ? null : signUpController.phoneNumberError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
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
                          'Đăng ký',
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
    );
  }
}

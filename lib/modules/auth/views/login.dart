import 'package:dyslexia_project/modules/auth/controllers/signin_controller.dart';
import 'package:dyslexia_project/modules/auth/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class Login extends StatelessWidget {

  // final authController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<SignInController>(
          init: SignInController(),
          builder: (controller) {
            return Stack(
              children: [

                Container(
                  padding: EdgeInsets.only(left: 35, top: 130),
                  child: const Text(
                    'Welcome\nBack',
                    style: TextStyle(color: Colors.black, fontSize: 33),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextField(
                                controller: controller.emailController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email_outlined),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Email",
                                    labelText: "Email",
                                    errorText: controller.validEmail ? null : controller.errorEmail,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),

                              const SizedBox(
                                height: 30,
                              ),
                              TextField(
                                controller: controller.passwordController,
                                style: TextStyle(color: Colors.black),
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.password),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: "Password",
                                    hintText: "Password",
                                    errorText: controller.validPassword ? null : controller.errorPassword,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)),

                                    )
                                ),

                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: () => controller.signIn(context),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                                        shape:
                                        MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                side: const BorderSide(color: Colors.blue)))),
                                    child: const Text(
                                      'Sign In',
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

                                        Get.to(() => SignUpPage());
                                      },
                                      child: Text('Chưa có tài khoản'),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Quên mật khẩu'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      );

  }
}
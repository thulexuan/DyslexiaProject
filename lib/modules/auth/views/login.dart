import 'package:dyslexia_project/common_widgets/sign_in_option.dart';
import 'package:dyslexia_project/modules/auth/controllers/signin_controller.dart';
import 'package:dyslexia_project/modules/auth/views/forgot_password_page.dart';
import 'package:dyslexia_project/modules/auth/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
        body: GetBuilder<SignInController>(
          init: SignInController(),
          builder: (controller) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text('Đăng nhập', style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          margin: const EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextField(
                                controller: controller.emailController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email_outlined),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Nhập email",
                                    labelText: "Email",
                                    errorText: controller.checkValid == true ? null : controller.errorEmail,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),

                              const SizedBox(
                                height: 30,
                              ),

                              // fill password

                              TextField(
                                controller: controller.passwordController,
                                style: TextStyle(color: Colors.black),
                                obscureText: isHiddenPassword ? true : false,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.password),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isHiddenPassword = !isHiddenPassword;
                                          });
                                        },
                                        child: isHiddenPassword ? const Icon(Icons.visibility_off) : Icon(Icons.visibility)
                                    ),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: "Mật khẩu",
                                    hintText: "Điền mật khẩu",
                                    errorText: controller.checkValid == true ? null : controller.errorPassword,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)),

                                    )
                                ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.to(ForgotPasswordPage());
                                    },
                                    child: const Text('Quên mật khẩu?'),
                                  ),
                                ],
                              ),

                              // sign in button
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.signIn(context);
                                      controller.saveEmailUsername(controller.emailController.text.trim());
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                                        shape:
                                        MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                side: const BorderSide(color: Colors.blue)))),
                                    child: const Text(
                                      'Đăng nhập',
                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                  children: const <Widget>[
                                    Expanded(
                                        child: Divider()
                                    ),

                                    Text("   Hoặc đăng nhập với   "),

                                    Expanded(
                                        child: Divider()
                                    ),
                                  ]
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        await controller.signInWithGoogle();
                                      },
                                      child: SignInOption(image_path: 'google.png')
                                  ),
                                  const SizedBox(width: 20,),
                                  SignInOption(image_path: 'apple.png')
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Chưa có tài khoản ? '),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(() => SignUpPage());
                                      },
                                      child: const Text('Đăng ký'),
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
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
  final signInController = Get.put(SignInController());

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
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10, MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.width / 10, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Đăng nhập', style: Theme.of(context).textTheme.headlineSmall,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40,),
                Obx(() => TextField(
                  controller: signInController.emailController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.email_outlined, size: MediaQuery.of(context).size.width / 16,),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Nhập email",
                      labelText: "Email",
                      errorText: signInController.emailError.value == '' ? null : signInController.emailError.value,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height / 40,),
                // fill password

                Obx(() => TextField(
                    controller: signInController.passwordController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    obscureText: isHiddenPassword ? true : false,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.password, size: MediaQuery.of(context).size.width / 16,),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHiddenPassword = !isHiddenPassword;
                            });
                          },
                          child: isHiddenPassword ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.visibility_off, size: MediaQuery.of(context).size.width / 16,),
                          ) : Icon(Icons.visibility, size: MediaQuery.of(context).size.width / 16,)
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      labelText: "Mật khẩu",
                      hintText: "Điền mật khẩu",
                      errorText: signInController.passwordError.value == '' ? null : signInController.passwordError.value,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),

                    )
                ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(ForgotPasswordPage());
                      },
                      child: Text('Quên mật khẩu?', style: Theme.of(context).textTheme.bodySmall,),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40,),
                // sign in button
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 12,
                    child: ElevatedButton(
                      onPressed: () {
                        signInController.signIn(context);
                        signInController.saveEmailUsername(signInController.emailController.text.trim());
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40,),
                Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider()
                      ),

                      Text("   Hoặc đăng nhập với   ", style: Theme.of(context).textTheme.bodyMedium,),

                      Expanded(
                          child: Divider()
                      ),
                    ]
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          await signInController.signInWithGoogle();
                        },
                        child: SignInOption(image_path: 'google.png')
                    ),
                    // const SizedBox(width: 20,),
                    // SignInOption(image_path: 'apple.png')
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chưa có tài khoản ? ', style: Theme.of(context).textTheme.bodyMedium,),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignUpPage());
                      },
                      child: Text('Đăng ký', style: Theme.of(context).textTheme.bodySmall),
                    ),

                  ],
                )
              ],

            ),
          ),
        )
      );

  }
}
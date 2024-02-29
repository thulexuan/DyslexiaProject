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

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController roleController = TextEditingController(text: 'Học sinh');

  List<String> list = <String>['Học sinh', 'Giáo viên'];
  late String role;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isHiddenPassword = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    signUpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    // print(orientation);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10, MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.width / 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Đăng ký', style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40,),
                  // fullname field
                  Obx(() => TextField(
                    controller: fullnameController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.person, size: MediaQuery.of(context).size.width / 16,),
                        ),
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

                  SizedBox(height: MediaQuery.of(context).size.height / 40,),

                  // email field
                  Obx(() => TextField(
                    controller: emailController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.email_outlined, size: MediaQuery.of(context).size.width / 16,),
                        ),
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

                  SizedBox(height: MediaQuery.of(context).size.height / 40,),

                  // password field
                  Obx(() => TextField(
                    controller: passwordController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    obscureText: isHiddenPassword ? true : false,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.lock, size: MediaQuery.of(context).size.width / 16,),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHiddenPassword = !isHiddenPassword;
                              });
                            },
                            child: isHiddenPassword ? Icon(Icons.visibility_off, size: MediaQuery.of(context).size.width / 16,) : Icon(Icons.visibility, size: MediaQuery.of(context).size.width / 16,),
                          ),
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

                  SizedBox(height: MediaQuery.of(context).size.height / 40,),

                  // confirm password field
                  Obx(() => TextField(
                    controller: confirmPasswordController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    obscureText: isHiddenPassword ? true : false,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.lock, size: MediaQuery.of(context).size.width / 16,),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHiddenPassword = !isHiddenPassword;
                              });
                            },
                            child: isHiddenPassword ? Icon(Icons.visibility_off, size: MediaQuery.of(context).size.width / 16,) : Icon(Icons.visibility, size: MediaQuery.of(context).size.width / 16,),
                          ),
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

                  SizedBox(height: MediaQuery.of(context).size.height / 40,),

                  Obx(() => TextField(
                    controller: phoneNumberController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.phone_android_outlined, size: MediaQuery.of(context).size.width / 16,),
                        ),
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

                  SizedBox(height: MediaQuery.of(context).size.height / 40,),

                  DropdownMenu<String>(
                      initialSelection: list.first,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      width: MediaQuery.of(context).size.width * 0.8,
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true
                      ),
                      controller: roleController,
                      label: Text('Vai trò', style: Theme.of(context).textTheme.bodyMedium),
                      onSelected: (String? newRole) {
                        setState(() {
                          role = newRole!;
                          roleController.text = newRole!;
                        });

                      },
                      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(value: value, label: value,
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 20
                                )
                              ),
                            )
                        );
                      }).toList(),
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height / 40,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 12,
                      child: ElevatedButton(
                        onPressed: () {
                          signUpController.signUp(fullnameController.text, emailController.text, passwordController.text, confirmPasswordController.text, phoneNumberController.text, roleController.text);
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => Login());
                        },
                        child: Text('Đã có tài khoản', style: Theme.of(context).textTheme.bodySmall,),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Quên mật khẩu', style: Theme.of(context).textTheme.bodySmall,),
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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/intro/first_time_login_page.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:dyslexia_project/modules/tests/views/test_page.dart';
import 'package:dyslexia_project/overview_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final textCustomizeController = Get.put(TextCustomizeController());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var validEmail;
  var validPassword;

  String errorEmail = "check your email";
  String errorPassword = "check your password";


  @override
  void onInit(){
    // Get called when controller is created
    super.onInit();
    validEmail = true;
    validPassword = true;
    update();
  }

  @override
  void onReady(){
    // Get called after widget is rendered on the screen
    super.onReady();
  }

  @override
  void onClose(){
    //Get called when controller is removed from memory
    super.onClose();
  }


  signIn(BuildContext context) async {
    String res = '';
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty) {
      validEmail = false;
      update();
    } else {
      validEmail = true;
      update();
    }
    if (password.length < 6 || password.isEmpty) {
      validPassword = false;
      update();
    } else {
      validPassword = true;
      update();
    }
    try {
      if (validEmail && validPassword) {
        await _auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        res = "success";
      } else {
        res = 'Please enter all the fields';
      }

    } catch (error) {
      res = error.toString();
    }
    if (res == "success") {
      saveEmailUsername(emailController.text.trim().toString());
      emailController.clear();
      passwordController.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // get isFirstTimeLogin from database. If == true -> navigate to testPage && update = false
      // is == false -> navigate to overviewPage
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email',
          isEqualTo: prefs.getString('email')) // add your condition here
          .get();
      final Object? data =
      snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

      var isFirstTimeLogin = data != null && data is Map<String, dynamic>
          ? data['isFirstTimeLogin']
          : 'fail to get isFirstTimeLogin' ;
      if (isFirstTimeLogin == true) {
        Get.to(TestPage());
        await snapshot.docs[0].reference.update({"isFirstTimeLogin": false});
      } else {
        Get.to(OverviewPage());
      }
      // await textCustomizeController.getData();
      // Get.to(const OverviewPage());
      onClose();
    }
  }

  Future<void> saveEmailUsername(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

}
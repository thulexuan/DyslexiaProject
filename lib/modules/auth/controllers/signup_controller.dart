import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/auth/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dyslexia_project/models/user.dart' as userModel;

class SignUpController extends GetxController {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var validFullName = true.obs;
  var validEmail = true.obs;
  var validPassword = true.obs;
  var validConfirmPassword = true.obs;
  var validPhoneNumber = true.obs;

  String errorEmail = "check your email";
  String errorPassword = "check your password";

  final defaultImageUrl = "https://img.freepik.com/free-vector/cute-corgi-dog-sitting-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-4181.jpg?w=2000";
  signUp(BuildContext context) async {
    String fullname = fullnameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String phoneNumber = phoneNumberController.text;

    String res = '';

    try {
      if (validFullName.value == true && validEmail.value == true && validPassword.value == true && validConfirmPassword.value == true && validPhoneNumber.value == true) {
        UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);

        userModel.User user = userModel.User(
            fullname: fullname,
            uid: credential.user!.uid,
            email: email,
            imageUrl: defaultImageUrl,
            phoneNumber: phoneNumber);

        await firestore.collection('users').doc(credential.user!.uid).set(user.toJson());

        res = "success";
      }
    } catch(err) {
      res = err.toString();
    }
    print(res);
    if (res == "success") {
      Get.to(() => Login());
    }
  }
}
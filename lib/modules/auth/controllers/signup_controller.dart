import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/auth/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  var checkValidOfAllFields = true.obs;
  var checkEmailExisted = false.obs;
  var checkPassword = true.obs;

  var fullNameError = ''.obs;
  var phoneNumberError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;


  final defaultImageUrl = "https://img.freepik.com/free-vector/cute-corgi-dog-sitting-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-4181.jpg?w=2000";

  signUp(BuildContext context) async {
    String fullname = fullnameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String phoneNumber = phoneNumberController.text;

    String res = '';

    try {
      checkAllFields();
      print(passwordError.value);
      if (fullNameError.value == '' && emailError.value == '' && passwordError.value == ''
      && confirmPasswordError.value == '' && phoneNumberError.value == '') {
        UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);

        userModel.User user = userModel.User(
            fullname: fullname,
            uid: credential.user!.uid,
            email: email,
            imageUrl: defaultImageUrl,
            phoneNumber: phoneNumber,
            fontSize: 20.0,
            letterSpacing: 0.0,
            wordSpacing: 0.0,
            lineSpacing: 1.1,
            fontFamily: 'Arial',
            backgroundColor: 'white',
            textColor: 'black',
            isFirstTimeLogin: true,
            doneExams: [],
            resultDoneExams: [],
            errorWords: [],
            voiceName: 'vi-vn-x-gft-network',
            pitch: 0.8
        );

        await firestore.collection('users').doc(credential.user!.uid).set({
          "fullname": fullname,
          "uid": credential.user!.uid,
          "email": email,
          "imageUrl": defaultImageUrl,
          "phoneNumber": phoneNumber,
          "fontSize": 20.0,
          "letterSpacing": 0.0,
          "wordSpacing": 0.0,
          "lineSpacing" : 1.1,
          "fontFamily": 'Arial',
          "backgroundColor" : 'white',
          "textColor" : 'black',
          "isFirstTimeLogin" : true,
          "doneExams" : [],
          "resultDoneExams" : [],
          "errorWords" : [],
          "voiceName" : 'vi-vn-x-gft-network',
          "pitch" : 0.8
        });

        res = "success";
      }
    } catch(err) {
      res = err.toString();
    }
    print(res);
    if (res == "success") {
      Get.to(() => Login());
    } else {
      if (res == "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        emailError.value = 'Email đã tồn tại';
      } else {
        emailError.value = '';
      }
    }

  }

  // check valid before consider whether email is already exist
  checkAllFields() {
    String fullname = fullnameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String phoneNumber = phoneNumberController.text;

    // check fullname

    if (fullname.isEmpty) {
      fullNameError.value = 'Vui lòng điền tên của bạn';
    } else {
      fullNameError.value = '';
    }

    // check phone number

    if (phoneNumber.isEmpty) {
      phoneNumberError.value = 'Vui lòng điền số điện thoại của bạn';
    } else {
      phoneNumberError.value = '';
    }

    // check email

    if (!email.contains('@') || email.isEmpty) {
      emailError.value = 'Email không hợp lệ';
    } else {
      emailError.value = '';
    }

    // check password.length > 5 ?
    if (password.isEmpty || password.length < 6) {
      passwordError.value = 'Mật khẩu phải chứa nhiều hơn 5 ký tự';
    } else {
      passwordError.value = '';
    }

    // check confirm password
    if (confirmPassword.isEmpty || password != confirmPassword) {
      confirmPasswordError.value = 'Mật khẩu không khớp';
    } else {
      confirmPasswordError.value = '';
    }
  }

  checkConfirmPassword() {
    String confirmPassword = confirmPasswordController.text;
    String password = passwordController.text;

    if (confirmPassword != password) {
      checkPassword.value = false;
    } else {
      checkPassword.value = true;
    }
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:dyslexia_project/overview_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dyslexia_project/models/user.dart' as userModel;

import '../../intro/intro_screen.dart';
import '../views/login.dart';


class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final textCustomizeController = Get.put(TextCustomizeController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var emailError = ''.obs;
  var passwordError = ''.obs;


  @override
  void onInit(){
    // Get called when controller is created
    super.onInit();
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
      emailError.value = 'Kiểm tra lại email';
    } else {
      emailError.value = '';
    }

    if (password.isEmpty || password.length < 6) {
      passwordError.value = 'Kiểm tra lại mật khẩu';
    } else {
      passwordError.value = '';
    }

    try {
      if (emailError.value == '' && passwordError.value == '') {
        await _auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        res = "success";
      }

    } catch (error) {
      res = error.toString();
      passwordError.value = 'Kiểm tra lại mật khẩu';
    }

    print(res);
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
        Get.to(const IntroScreen());
        await snapshot.docs[0].reference.update({"isFirstTimeLogin": false});
      } else {
        Get.to(const OverviewPage());
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

  signInWithGoogle() async {

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    String res = '';

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final QuerySnapshot userRef = await FirebaseFirestore.instance
          .collection('users')
          .where('email',
          isEqualTo: userCredential.user?.email ?? '')
          .get();

      if (userRef.docs.isEmpty) {
        userModel.User user = userModel.User(
            fullname: userCredential.user?.displayName ?? 'no name',
            uid: userCredential.user?.uid ?? 'no',
            email: userCredential.user?.email ?? 'no',
            imageUrl: userCredential.user?.photoURL ?? 'no',
            phoneNumber: userCredential.user?.phoneNumber ?? 'no',
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

        await firestore.collection('users').doc(userCredential.user!.uid).set({
          "fullname": userCredential.user?.displayName ?? 'no name',
          "uid": userCredential.user?.uid ?? 'no',
          "email": userCredential.user?.email ?? 'no',
          "imageUrl": userCredential.user?.photoURL ?? 'no',
          "phoneNumber": userCredential.user?.phoneNumber ?? 'no',
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

      } else {
        res = "success";
      }
    }
    catch (err) {
      print(err.toString());
    }

    // if successfully login -> navigate page
    if (res == "success") {
      saveEmailUsername(googleUser?.email ?? 'no');

      SharedPreferences prefs = await SharedPreferences.getInstance();

      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
          .where('email', isEqualTo: prefs.getString('email')).get();

      final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

      var isFirstTimeLogin = data != null && data is Map<String, dynamic>
          ? data['isFirstTimeLogin']
          : 'fail to get isFirstTimeLogin' ;
      if (isFirstTimeLogin == true) {
        Get.to(const IntroScreen());
        await snapshot.docs[0].reference.update({"isFirstTimeLogin": false});
      } else {
        Get.to(const OverviewPage());
      }
      // await textCustomizeController.getData();
      // Get.to(const OverviewPage());
      onClose();
    }

  }

  signOut() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<UserInfo> providerData = user.providerData;
      if (providerData.isNotEmpty) {
        for (var userInfo in providerData) {
          String signInMethod = userInfo.providerId;
          print('Sign-in method: $signInMethod');
          if (signInMethod == "google.com") {
            await GoogleSignIn().signOut();
          } else {
            await _auth.signOut();
          }
        }
      }
    }

  }


}
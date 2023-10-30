import 'package:dyslexia_project/modules/auth/views/login.dart';
import 'package:dyslexia_project/modules/tests/views/testTwoWord.dart';
import 'package:dyslexia_project/test.dart';
import 'package:dyslexia_project/testContrast.dart';
import 'package:dyslexia_project/test_spacing.dart';
import 'package:dyslexia_project/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/intro/first_time_login_page.dart';
import 'modules/intro/intro_screen.dart';
import 'modules/tests/views/test_letter.dart';
import 'modules/tests/views/test_mirror_letter.dart';
import 'modules/tests/views/test_one_word.dart';
import 'modules/tests/views/test_page.dart';
import 'modules/tests/views/test_sentence_page.dart';
import 'overview_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: Login()
    );
  }
}





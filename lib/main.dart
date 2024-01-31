import 'package:dyslexia_project/modules/auth/views/login.dart';
import 'package:dyslexia_project/test.dart';
import 'package:dyslexia_project/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/auth/views/sign_up.dart';
import 'modules/profile/done_process_detail.dart';
import 'modules/teacher_role/overview_page_teacher.dart';

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





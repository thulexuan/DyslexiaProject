import 'package:dyslexia_project/modules/auth/views/login.dart';
import 'package:dyslexia_project/modules/readText/views/display_text_page.dart';
import 'package:dyslexia_project/test.dart';
import 'package:dyslexia_project/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'editor_page.dart';
import 'modules/auth/views/sign_up.dart';
import 'modules/customizeText/views/text_customize_option_page.dart';
import 'modules/profile/done_process_detail.dart';
import 'modules/teacher_role/overview_page_teacher.dart';
import 'modules/tests/views/test_letter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final MediaQueryData mediaQueryData = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  final double deviceHeight = mediaQueryData.size.height;
  final double deviceWidth = mediaQueryData.size.width;
  Orientation deviceOrientation = mediaQueryData.orientation;
  runApp(MyApp(deviceHeight: deviceHeight, deviceWidth: deviceWidth, deviceOrientation: deviceOrientation, ));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key, required this.deviceHeight, required this.deviceWidth, required this.deviceOrientation,});

  final double deviceHeight;
  final double deviceWidth;
  final Orientation deviceOrientation;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return DefaultTextHeightBehavior(
      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.customThemeData(deviceWidth, deviceHeight, deviceOrientation),
        home: Login()
      ),
    );
  }
}





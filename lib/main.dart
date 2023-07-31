import 'package:dyslexia_project/common_widgets/bottomNavigationBar.dart';
import 'package:dyslexia_project/modules/auth/views/login.dart';
import 'package:dyslexia_project/modules/home/homePage/home_page.dart';
import 'package:dyslexia_project/overview_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const OverviewPage(),
    );
  }
}

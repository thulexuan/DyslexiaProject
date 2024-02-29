import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:dyslexia_project/modules/customizeText/controllers/text_customize_controller.dart';
import 'package:dyslexia_project/modules/readText/views/read_options_page.dart';
import 'package:dyslexia_project/modules/tests/controllers/test_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../exams/views/exam_collection_page.dart';
import '../../profile/profile_page.dart';


class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    ReadOptions(),
    // const Text(
    //   'Trang sach noi',
    //   style: optionStyle,
    // ),
    ExamCollectionPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  final testController = Get.put(TestController());
  final textCustomizeController = Get.put(TextCustomizeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textCustomizeController.getData();
    print('----start----');
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    SoundFunction().stopSpeaking();
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: orientation == Orientation.landscape ? MediaQuery.of(context).size.height / 30 : MediaQuery.of(context).size.width / 20,
        unselectedFontSize: orientation == Orientation.landscape ? MediaQuery.of(context).size.height / 30 : MediaQuery.of(context).size.width / 20,
        selectedIconTheme: IconThemeData(size: orientation == Orientation.landscape ? MediaQuery.of(context).size.height / 25 : MediaQuery.of(context).size.width / 20),
        unselectedIconTheme: IconThemeData(size: orientation == Orientation.landscape ? MediaQuery.of(context).size.height / 25 : MediaQuery.of(context).size.width / 20),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            label: 'Đọc',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.library_books),
          //   label: 'Thư viện sách',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Kiểm tra',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cá nhân',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

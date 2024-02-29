import 'package:dyslexia_project/modules/common/views/white_page.dart';
import 'package:dyslexia_project/modules/teacher_role/setting_page.dart';
import 'package:flutter/material.dart';

import 'createExam/choose_file_page.dart';

class OverviewTeacherPage extends StatefulWidget {
  const OverviewTeacherPage({Key? key}) : super(key: key);

  @override
  State<OverviewTeacherPage> createState() => _OverviewTeacherPageState();
}

class _OverviewTeacherPageState extends State<OverviewTeacherPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    CreateExamPage(),
    SettingPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: MediaQuery.of(context).size.width / 20,
        unselectedFontSize: MediaQuery.of(context).size.width / 20,
        selectedIconTheme: IconThemeData(size: MediaQuery.of(context).size.width / 20),
        unselectedIconTheme: IconThemeData(size: MediaQuery.of(context).size.width / 20),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            label: 'Tạo bài kiểm tra',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

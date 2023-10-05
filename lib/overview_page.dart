import 'package:dyslexia_project/modules/readText/views/read_options_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ReadOptions(),
    Text(
      'Trang sach noi',
      style: optionStyle,
    ),
    Text(
      'Kiem tra',
      style: optionStyle,
    ),
    Text(
      'Cai dat',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            label: 'Đọc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Thư viện sách',
          ),
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

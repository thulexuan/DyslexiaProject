// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../modules/home/home_page.dart';
//
// class BottomNavigationBarWidget extends StatefulWidget {
//   const BottomNavigationBarWidget({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
// }
//
// class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     HomePage(),
//     Text(
//       'Index 1: Business',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 2: School',
//       style: optionStyle,
//     ),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Trang chủ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Cá nhân',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Cài đặt',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       );
//
//   }
// }

import 'package:dyslexia_project/modules/customizeText/views/customize_option_page.dart';
import 'package:dyslexia_project/modules/customizeText/views/text_customize_option_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Tùy chỉnh'),
            onTap: () {
              Get.to(CustomizeOptionPage());
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Chọn lại ảnh'),
            onTap: () {
              // Add your navigation logic here
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
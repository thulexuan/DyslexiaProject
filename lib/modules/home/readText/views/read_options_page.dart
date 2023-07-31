import 'package:dyslexia_project/modules/home/homePage/home_page.dart';
import 'package:dyslexia_project/modules/home/readText/controllers/recognize_text_controller.dart';
import 'package:dyslexia_project/modules/home/readText/views/display_image_page.dart';
import 'package:dyslexia_project/modules/home/readText/views/widgets/read_option_widget.dart';
import 'package:dyslexia_project/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReadOptions extends StatelessWidget {
   ReadOptions({Key? key}) : super(key: key);
   final controller = Get.put(RecognizedTextController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Read Options Page"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                controller.getImage(ImageSource.camera);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  DisplayImagePage()),
                );
              },
              child: ReadOptionWidget(description: "Chụp ảnh", icon: Icon(Icons.camera_alt_sharp))
          ),
          GestureDetector(
              onTap: () {
                controller.getImage(ImageSource.gallery);
                print(controller.selectedImagePath.value);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  DisplayImagePage()),
                );
              },
              child: ReadOptionWidget(description: "Chọn ảnh từ thư viện ảnh", icon: Icon(Icons.image_sharp))
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  OverviewPage()),
                    );
                  },
                  icon: Icon(Icons.home)
              ),
              Text('Trở về trang chủ')
            ],
          )
        ],
      )
    );
  }
}

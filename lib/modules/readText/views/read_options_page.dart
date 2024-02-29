import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:dyslexia_project/modules/readText/views/widgets/read_option_widget.dart';
import 'package:dyslexia_project/modules/common/views/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../controllers/recognize_text_controller.dart';
import 'display_image_page.dart';

class ReadOptions extends StatefulWidget {
   const ReadOptions({Key? key}) : super(key: key);

  @override
  State<ReadOptions> createState() => _ReadOptionsState();
}

class _ReadOptionsState extends State<ReadOptions> {
   final controller = Get.put(RecognizedTextController());

  @override
  Widget build(BuildContext context) {
    SoundFunction().stopSpeaking();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Đọc văn bản', style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),), automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height / 12,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.height / 4,
              height: MediaQuery.of(context).size.height / 4,
              child: Image.asset('assets/images/read_book.jpg', fit: BoxFit.contain,),
            ),
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
              child: Text('Chọn văn bản cần đọc bằng một trong các cách sau',
                style: Theme.of(context).textTheme.bodyLarge
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      controller.getImage(ImageSource.camera);
                      print(controller.selectedImagePath.value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  DisplayImagePage()),
                      );
                    },
                    child: ReadOptionWidget(description: "Chụp ảnh", icon: Icon(Icons.camera_alt_sharp, size: MediaQuery.of(context).size.width / 10,))
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
                    child: ReadOptionWidget(description: "Chọn ảnh từ thư viện ảnh", icon: Icon(Icons.image_sharp, size: MediaQuery.of(context).size.width / 10,))
                ),
              ],
            )


          ],
        ),
      )
    );
  }
}

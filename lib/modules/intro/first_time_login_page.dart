import 'package:dyslexia_project/modules/tests/views/test_page.dart';
import 'package:dyslexia_project/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FirstTimeLoginPage extends StatelessWidget {
  const FirstTimeLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(50),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Image.asset('assets/images/take_test_1.png', fit: BoxFit.fill,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Bạn có muốn làm bài test?', style: TextStyle(fontSize: 20),),
            ),
            SizedBox(
              width: 210,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(const TestPage());
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.check, size: 30,),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Làm bài', style: TextStyle(fontSize: 24),),
                      ),
                    ],
                  ),
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 210,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const OverviewPage());
                },
                child: Row(
                  children: const [
                    Icon(Icons.close, size: 30,),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Không làm', style: TextStyle(fontSize: 24),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

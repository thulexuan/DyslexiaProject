import 'package:dyslexia_project/modules/tests/views/test_page.dart';
import 'package:dyslexia_project/modules/common/views/overview_page.dart';
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
              child: Text('Bạn có muốn làm bài test?', style: Theme.of(context).textTheme.bodyMedium,),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 10,
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(const TestPage());
                  },
                  child: Row(
                    children: [
                      Icon(Icons.check, size: Theme.of(context).iconTheme.size,),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Làm bài', style: Theme.of(context).textTheme.labelSmall),
                      ),
                    ],
                  ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40,),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 10,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const OverviewPage());
                },
                child: Row(
                  children: [
                    Icon(Icons.close, size: Theme.of(context).iconTheme.size,),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Không làm', style: Theme.of(context).textTheme.labelSmall),
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

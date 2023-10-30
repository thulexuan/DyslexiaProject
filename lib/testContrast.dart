import 'dart:ui';

import 'package:flutter/material.dart';

class TestContrast extends StatelessWidget {
   TestContrast({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    print(queryData.size.width);
    return Scaffold(
      appBar: AppBar(title: Text('Test contrast'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('dyslexia', style: TextStyle(fontFamily: 'Arial', fontSize: 30, color: Colors.black.withOpacity(0.25)),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('dyslexia', style: TextStyle(fontFamily: 'Arial', fontSize: 30, color: Colors.black.withOpacity(0.5)),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('dyslexia', style: TextStyle(fontFamily: 'Arial', fontSize: 120, color: Colors.black.withOpacity(0.75)),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('dyslexia', style: TextStyle(fontFamily: 'Arial', fontSize: 40, color: Colors.black.withOpacity(1)),),
            )
          ],
        ),
      ),
    );
  }
}

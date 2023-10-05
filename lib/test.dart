import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(0, 0, 0, 0.25),
        child: Center(
          child: Text("bà", style: TextStyle(fontSize: 35, letterSpacing: 5),),
        ),
      ),
    );
  }
}

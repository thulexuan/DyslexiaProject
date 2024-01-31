import 'package:flutter/material.dart';


class Test extends StatelessWidget {
  final TextEditingController _controller = TextEditingController(text: 'Hello, World!');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test'),),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: TextField(
          controller: _controller,
        )
      ),
    );
  }
}

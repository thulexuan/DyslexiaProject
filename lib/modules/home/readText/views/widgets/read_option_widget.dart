import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadOptionWidget extends StatelessWidget {

  final String description;
  final Icon icon;

  ReadOptionWidget({
    required this.description,
    required this.icon
});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 20,),
            Text(description),
          ],
        ),
    );
  }
}

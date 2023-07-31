import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {

  final String title;
  final String description;
  final String image;

  OptionItem({
    required this.title,
    required this.description,
    required this.image
});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
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
      child: Column(
        children: [
          Container(
            width: 200,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white70,
              // image: DecorationImage(
              //     image: NetworkImage("image"),
              //     fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10,),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text(description, textAlign: TextAlign.center,)
        ],
      )
    );
  }
}

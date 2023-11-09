import 'package:flutter/material.dart';

class BackgroundOption extends StatelessWidget {

  Color color;
  bool isSelected;

  BackgroundOption({
    required this.color,
    required this.isSelected
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(
              color: isSelected ? Colors.red : Colors.grey.shade300,
              width: 5,
          )
      ),
    );
  }
}

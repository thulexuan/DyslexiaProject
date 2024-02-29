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
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      width: orientation == Orientation.portrait ? 50 : 100,
      height: orientation == Orientation.portrait ? 50 : 100,
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

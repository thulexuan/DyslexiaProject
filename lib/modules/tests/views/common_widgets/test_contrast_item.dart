import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestContrastItem extends StatefulWidget {

  final String word;
  final String fontFamily;
  final double fontSize;
  final bool isSelected;
  Color backgroundColor;
  Color textColor;
  double opacity;

  TestContrastItem({
    required this.word,
    required this.fontFamily,
    required this.fontSize,
    required this.isSelected,
    required this.backgroundColor,
    required this.textColor,
    required this.opacity
  });

  @override
  State<TestContrastItem> createState() => _TestContrastItemState();
}

class _TestContrastItemState extends State<TestContrastItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 60,
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: widget.isSelected == true ? Colors.red : Colors.white,
            width: widget.isSelected == true ? 2 : 0
          )
      ),
      child: Center(
          child: Text(
            widget.word,
            style: TextStyle(
                fontSize: widget.fontSize,
                fontFamily: widget.fontFamily,
                fontWeight: widget.isSelected == true ? FontWeight.bold : FontWeight.normal,
                color: widget.textColor.withOpacity(widget.opacity)
            ),
            textAlign: TextAlign.center,
          )
      ),
    );
  }
}

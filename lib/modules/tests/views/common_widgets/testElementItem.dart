import 'package:flutter/material.dart';

class TestElementItem extends StatefulWidget {

  final String word;
  final String fontFamily;
  final double fontSize;
  final double letterSpacing;
  final double wordSpacing;
  final bool isSelected;

  TestElementItem({
    required this.word,
    required this.fontFamily,
    required this.fontSize,
    required this.letterSpacing,
    required this.wordSpacing,
    required this.isSelected,
});

  @override
  State<TestElementItem> createState() => _TestElementItemState();
}

class _TestElementItemState extends State<TestElementItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.isSelected);
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        color: widget.isSelected == true ? Colors.yellow : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
          child: Text(
            widget.word,
            style: TextStyle(
                fontSize: widget.fontSize,
                fontFamily: widget.fontFamily,
                letterSpacing: widget.letterSpacing,
                wordSpacing: widget.wordSpacing,
                fontWeight: widget.isSelected == true ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          )
      ),
    );
  }
}

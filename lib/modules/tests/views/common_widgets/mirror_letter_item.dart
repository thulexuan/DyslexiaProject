import 'package:flutter/material.dart';

class MirrorLetterItem extends StatefulWidget {

  String letter;
  String fontFamily;
  double fontSize;
  bool isSelected;

  MirrorLetterItem({
    required this.letter,
    required this.fontFamily,
    required this.fontSize,
    required this.isSelected,
});

  @override
  State<MirrorLetterItem> createState() => _MirrorLetterItemState();
}

class _MirrorLetterItemState extends State<MirrorLetterItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
          color: widget.isSelected == true ? Colors.yellow : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
          child: Text(
            widget.letter,
            style: TextStyle(
                fontSize: widget.fontSize,
                fontFamily: widget.fontFamily,
                fontWeight: widget.isSelected == true ? FontWeight.bold : FontWeight.normal,
                color: Colors.black
            ),
            textAlign: TextAlign.center,
          )
      ),
    );
  }
}

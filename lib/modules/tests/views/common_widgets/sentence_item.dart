import 'package:flutter/material.dart';

class SentenceItem extends StatefulWidget {

  String sentence;
  double fontSize;
  String fontFamily;
  bool isSelected;

  SentenceItem({
    required this.sentence,
    required this.fontSize,
    required this.fontFamily,
    required this.isSelected
});

  @override
  State<SentenceItem> createState() => _SentenceItemState();
}

class _SentenceItemState extends State<SentenceItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 200,
        height: 120,
        decoration: BoxDecoration(
            color: widget.isSelected == true ? Colors.yellow : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: Row(
          children: [
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      widget.sentence,
                      style: TextStyle(
                          fontSize: widget.fontSize,
                          fontFamily: widget.fontFamily,
                          fontWeight: widget.isSelected == true ? FontWeight.bold : FontWeight.normal,
                          color: Colors.black
                      ),
                    ),
                ),

            ),
          ],
        ),
      ),
    );
  }
}

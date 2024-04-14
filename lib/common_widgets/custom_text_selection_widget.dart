import 'package:flutter/cupertino.dart';

class CustomTextSelectionWidget extends TextSelection {
  CustomTextSelectionWidget({
    required this.style, required super.baseOffset, required super.extentOffset, required this.selectedText
});

  final TextStyle style;
  final String selectedText;

  @override
  Widget build(BuildContext context) {
    return Text(selectedText,
      style: style,
    );
  }
}
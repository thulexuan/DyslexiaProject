import 'package:flutter/material.dart';

class CustomText extends Text {
  bool isSelected;
  TextStyle normalStyle;
  TextStyle selectedStyle;

  CustomText(
      String data, {
        Key? key,
        TextStyle? style,
        TextAlign? textAlign,
        TextDirection? textDirection,
        bool? softWrap,
        TextOverflow? overflow,
        double? textScaleFactor,
        int? maxLines,
        String? semanticsLabel,
        TextWidthBasis? textWidthBasis,
        required this.isSelected,
        required this.normalStyle,
        required this.selectedStyle,
      }) : super(
    data,
    key: key,
    style: style,
    textAlign: textAlign,
    textDirection: textDirection,
    softWrap: softWrap,
    overflow: overflow,
    textScaleFactor: textScaleFactor,
    maxLines: maxLines,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
  );



  @override
  Widget build(BuildContext context) {
    return Text(
      data!,
      style: isSelected ? selectedStyle : normalStyle,
    );
  }

}
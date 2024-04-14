import 'dart:ui' as ui show Locale, LocaleStringAttribute, ParagraphBuilder, SpellOutStringAttribute, StringAttribute;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTextSpan extends TextSpan {

  bool isSelected;
  TextStyle normalStyle;
  TextStyle selectedStyle;

  CustomTextSpan({
    TextStyle? style,
    String? text,
    List<InlineSpan>? children,
    GestureRecognizer? recognizer,
    required this.isSelected,
    required this.normalStyle,
    required this.selectedStyle
  }) : super(
    style: style,
    text: text,
    children: children,
    recognizer: recognizer,
  );

  @override
  void build(
      ui.ParagraphBuilder builder, {
        double textScaleFactor = 1.0,
        List<PlaceholderDimensions>? dimensions,
      }) {
    assert(debugAssertIsValid());
    // final bool hasStyle = style != null;
    // if (hasStyle) {
    //   builder.pushStyle(style!.getTextStyle(textScaleFactor: textScaleFactor));
    // }
    if (isSelected) {
      builder.pushStyle(selectedStyle!.getTextStyle(textScaleFactor: textScaleFactor));
    } else {
      builder.pushStyle(normalStyle!.getTextStyle(textScaleFactor: textScaleFactor));
    }
    if (text != null) {
      try {
        builder.addText(text!);
      } on ArgumentError catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'painting library',
          context: ErrorDescription('while building a TextSpan'),
        ));
        // Use a Unicode replacement character as a substitute for invalid text.
        builder.addText('\uFFFD');
      }
    }
    if (children != null) {
      for (final InlineSpan child in children!) {
        assert(child != null);
        child.build(
          builder,
          textScaleFactor: textScaleFactor,
          dimensions: dimensions,
        );
      }
    }
    builder.pop();
    // if (hasStyle) {
    //   builder.pop();
    // }
  }


}


import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum textColor {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const textColor(this.label, this.color);
  final String label;
  final Color color;
}

class TextCustomizeController extends GetxController {
  var current_font_size = 20.obs;

}
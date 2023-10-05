import 'package:dyslexia_project/data/color_mapping.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dropdown.dart';

class Counter extends StatefulWidget {
   Counter({Key? key, required this.min, required this.max, required this.step, required this.value, required this.onChanged}) : super(key: key);

  final double min;
  final double max;
  final double step;
  double value;
   final ValueChanged<double>? onChanged;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {


  @override
  Widget build(BuildContext context) {



    return Row(
      children: [
        IconButton(
            onPressed: onRemoveButton,
            icon: Icon(Icons.remove, color: widget.value.toStringAsFixed(1) == widget.min.toStringAsFixed(1) ? Colors.grey : Colors.black,)
        ),
        Text(
          widget.value.toStringAsFixed(1)
        ),
        IconButton(
            onPressed: onAddButton,
            icon: Icon(Icons.add, color: widget.value.toStringAsFixed(1) == widget.max.toStringAsFixed(1) ? Colors.grey : Colors.black,)
        )
      ],
    );
  }

  void onRemoveButton() {
    if (widget.value > widget.min) {
      setState(() {
        widget.value -= widget.step;
      });
    }
    if (widget.value < 0) {
      setState(() {
        widget.value = 0;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(widget.value);
    }
  }

  void onAddButton() {
    if (widget.value < widget.max) {
      setState(() {
        widget.value += widget.step;
      });
    }
    if (widget.value > widget.max) {
      setState(() {
        widget.value = widget.max;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(widget.value);
    }
  }
}

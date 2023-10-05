import 'package:flutter/material.dart';

class TextCustomOption extends StatefulWidget {

  @override
  State<TextCustomOption> createState() => _TextCustomOptionState();

  double currentValue;
  String option;
  double step;
  double min;
  double max;
  final ValueChanged<double>? onChanged;

  TextCustomOption({
    required this.currentValue,
    required this.option,
    required this.step, this.onChanged, required this.max, required this.min
});
}

class _TextCustomOptionState extends State<TextCustomOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(child: Text(widget.option, style: TextStyle(fontWeight: FontWeight.bold),), alignment: Alignment.topLeft,),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: decrease,
                  icon: Icon(Icons.remove,
                    color: widget.currentValue.toStringAsFixed(1) == widget.min.toStringAsFixed(1) ? Colors.grey : Colors.black,)
              ),
              Slider(
                  value: widget.currentValue,
                  label: widget.currentValue.toStringAsFixed(1),
                  min: widget.min,
                  max: widget.max,
                  onChanged: (double value) {
                    setState(() {
                      widget.currentValue = value;
                      widget.onChanged!(widget.currentValue);
                    });
                  }
              ),
              IconButton(
                  onPressed: increase,
                  icon: Icon(Icons.add,
                    color: widget.currentValue.toStringAsFixed(1) == widget.max.toStringAsFixed(1) ? Colors.grey : Colors.black,)
              ),
              Text(widget.currentValue.toStringAsFixed(1)),
            ],
          )
        ),
      ],
    );
  }

  void increase() {
    if (widget.currentValue < widget.max) {
      setState(() {
        widget.currentValue += widget.step;
      });
    }
    if (widget.currentValue > widget.max) {
      setState(() {
        widget.currentValue = widget.max;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(widget.currentValue);
    }
  }

  void decrease() {
    if (widget.currentValue > widget.min) {
      setState(() {
        widget.currentValue -= widget.step;
      });
    }
    if (widget.currentValue < widget.min) {
      setState(() {
        widget.currentValue = widget.min;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(widget.currentValue);
    }
  }
}

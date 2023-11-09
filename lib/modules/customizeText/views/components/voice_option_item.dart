import 'package:flutter/material.dart';

class VoiceOptionItem extends StatefulWidget {

  String voiceName;
  bool isSelected;

  VoiceOptionItem({
    required this.voiceName,
    required this.isSelected
}
);
  @override
  State<VoiceOptionItem> createState() => _VoiceOptionItemState();
}

class _VoiceOptionItemState extends State<VoiceOptionItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.voiceName, style: TextStyle(
              color: widget.isSelected ? Colors.blue : Colors.black,
              fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal),
          ),
          widget.isSelected ? Icon(Icons.check, color: Colors.blue,) : Container(),
        ],
      ),
    );
  }
}

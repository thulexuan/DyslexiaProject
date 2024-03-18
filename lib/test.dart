import 'package:flutter/material.dart';



class DisplayText extends StatefulWidget {
  @override
  _DisplayTextState createState() => _DisplayTextState();
}

class _DisplayTextState extends State<DisplayText> {
  bool canEdit = false; // Initial state is not editable
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editable Text Field'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Toggle Editable:'),
                Switch(
                  value: canEdit,
                  onChanged: (value) {
                    setState(() {
                      canEdit = value; // Update editability state
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: _controller,
              readOnly: !canEdit, // Invert readOnly based on canEdit
              decoration: InputDecoration(
                hintText: 'Type something...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

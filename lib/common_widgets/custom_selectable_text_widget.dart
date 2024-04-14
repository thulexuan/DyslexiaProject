import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CustomSelectableText extends StatefulWidget {

  String data;
  TextStyle normalStyle;
  TextStyle selectedStyle;
  bool isSelected;

  CustomSelectableText({
    required this.data,
    required this.normalStyle,
    required this.selectedStyle,
    required this.isSelected
});

  @override
  State<CustomSelectableText> createState() => _CustomSelectableTextState();
}

class _CustomSelectableTextState extends State<CustomSelectableText> {

  FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: Colors.yellow,
        cursorColor: Colors.red
      ),
      child: SelectableText(
        widget.data,
        onSelectionChanged: (TextSelection selection, SelectionChangedCause? cause) {
          tts.setLanguage('vi-VN');
          // tts.setVolume(1.0);
          // tts.setSpeechRate(0.5);
          // tts.setPitch(0.8);
          tts.speak(widget.data.substring(selection.baseOffset, selection.extentOffset));
        },

        style: widget.isSelected ? widget.selectedStyle : widget.normalStyle,
        contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {

          final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
          buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
            return buttonItem.type == ContextMenuButtonType.cut;
          });
          buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
            return buttonItem.type == ContextMenuButtonType.copy;
          });
          buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
            return buttonItem.type == ContextMenuButtonType.selectAll;
          });
          buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
            return buttonItem.type == ContextMenuButtonType.paste;
          });

          return AdaptiveTextSelectionToolbar.buttonItems(
            anchors: editableTextState.contextMenuAnchors,
            buttonItems: buttonItems,
          );
        },
      ),
    );
  }
}

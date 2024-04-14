import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';



class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   String extractedText = "Hôm nay là chủ nhật.\nMai rất vui vì Mai được đi công viên chơi";




   late int start_pos;
   late int end_pos;

  @override
  Widget build(BuildContext context) {
    String htmlContent = """
<body>

<p>$extractedText</p>

</body>
""";
    // or use HTML.toRichText()
    final TextSpan textSpan = HTML.toTextSpan(
      context,
      htmlContent,
      linksCallback: (dynamic link) {
        debugPrint('You clicked on ${link.toString()}');
      },
      // as name suggests, optionally set the default text style
      defaultTextStyle: TextStyle(color: Colors.grey[700]),
      overrideStyle: <String, TextStyle>{
        'p': const TextStyle(fontSize: 17.3),
        'a': const TextStyle(wordSpacing: 10, letterSpacing: 5),
        // specify any tag not just the supported ones,
        // and apply TextStyles to them and/override them
      },
    );

    return Scaffold(
        appBar: AppBar(title: const Text('Demo')),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: SelectableText.rich(textSpan,
            onSelectionChanged: (TextSelection selection, _) {
            setState(() {
              start_pos = selection.baseOffset;
              end_pos = selection.extentOffset;
            });
            },
            contextMenuBuilder: (BuildContext context,
                EditableTextState editableTextState) {

              final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;

              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: buttonItems,
              );
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          print(extractedText.length);
          setState(() {
            extractedText = extractedText.substring(0, start_pos) + "<i>" + extractedText.substring(start_pos, end_pos) + "</i>"
                + extractedText.substring(end_pos, extractedText.length);
            print(extractedText);
            print(htmlContent);
          });
        },
        child: Icon(Icons.bolt),
      ),
      );

  }
}
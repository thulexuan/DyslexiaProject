//
// import 'package:dyslexia_project/common_widgets/each_word.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);
//
//   @override
//   State<TestPage> createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//
//   List<String> words = ['this ', 'xe đạp ', 'a ', 'test ', 'ne ', 'ahihi'];
//
//   Widget getTextWidgets(List<String> strings)
//   {
//     List<Widget> list = <Widget>[];
//     for(var i = 0; i < strings.length; i++){
//       list.add(new EachWord(word: strings[i], image_url: '',));
//     }
//     return new Container(child: Wrap(children: list,),);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 300,),
//           getTextWidgets(words)
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


const String emailAddress = 'me@example.com';
const String text = 'Select the email address and open the menu: $emailAddress';

class EditableTextToolbarBuilderExampleApp extends StatefulWidget {
  const EditableTextToolbarBuilderExampleApp({super.key});

  @override
  State<EditableTextToolbarBuilderExampleApp> createState() =>
      _EditableTextToolbarBuilderExampleAppState();
}

class _EditableTextToolbarBuilderExampleAppState
    extends State<EditableTextToolbarBuilderExampleApp> {
  final TextEditingController _controller = TextEditingController(
    text: text,
  );

  void _showDialog(BuildContext context) {
    Navigator.of(context).push(
      DialogRoute<void>(
        context: context,
        builder: (BuildContext context) =>
         AlertDialog(
          actions: [
            Column(
              children: [
                Image.asset('assets/images/apple.png'),
              ],
            )
          ],
        ),
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    // On web, disable the browser's context menu since this example uses a custom
    // Flutter-rendered context menu.
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom button for emails'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(height: 20.0),
              TextField(
                controller: _controller,
                  contextMenuBuilder: (BuildContext context,
                      EditableTextState editableTextState) {

                    final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
                    final TextEditingValue value = _controller.value;
                    buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                      return buttonItem.type == ContextMenuButtonType.cut;
                    });
                    buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                      return buttonItem.type == ContextMenuButtonType.copy;
                    });
                    buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                      return buttonItem.type == ContextMenuButtonType.selectAll;
                    });
                      buttonItems.insert(0,
                        ContextMenuButtonItem(
                          label: 'Ảnh',
                          onPressed: () async {
                            ContextMenuController.removeAny();
                             _showDialog(
                            context,
                            );
                            print(value.selection.textInside(value.text));
                          },
                        ),
                      );

                    return AdaptiveTextSelectionToolbar.buttonItems(
                      anchors: editableTextState.contextMenuAnchors,
                      buttonItems: buttonItems,
                    );
                  },
              )
              // TextField(
              //   controller: _controller,
              //   maxLines: null,
              //   contextMenuBuilder: (BuildContext context,
              //       EditableTextState editableTextState) {
              //     final List<ContextMenuButtonItem> buttonItems =
              //         editableTextState.contextMenuButtonItems;
              //     // Here we add an "Email" button to the default TextField
              //     // context menu for the current platform, but only if an email
              //     // address is currently selected.
              //     final TextEditingValue value = _controller.value;
              //
              //       buttonItems.insert(
              //         0,
              //         ContextMenuButtonItem(
              //           label: 'edit',
              //           onPressed: () {
              //             ContextMenuController.removeAny();
              //             print(value.selection.textInside(value.text));
              //           },
              //         ),
              //       );
              //
              //     return AdaptiveTextSelectionToolbar.buttonItems(
              //       anchors: editableTextState.contextMenuAnchors,
              //       buttonItems: buttonItems,
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

bool _isValidEmail(String text) {
  return RegExp(
    r'(?<name>[a-zA-Z0-9]+)'
    r'@'
    r'(?<domain>[a-zA-Z0-9]+)'
    r'\.'
    r'(?<topLevelDomain>[a-zA-Z0-9]+)',
  ).hasMatch(text);
}

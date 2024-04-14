import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isBold = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Demo')),
        body: Center(
          child: SelectableText.rich(
            TextSpan(
              children: <InlineSpan> [
                for (int i=0; i <5; i++)
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isBold = !isBold;
                        });
                        print(isBold);
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 't', style: isBold ? TextStyle(color: Colors.red) : TextStyle(color: Colors.black)),
                            TextSpan(text: 'h')
                          ]
                        )
                      ),
                    ))
                    ]
                  ),

            ),
        )
        ),
      );

  }
}
import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Font size with font family'),),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Column(
            children: [
              // row 1
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text('16pt', style: TextStyle(fontSize: 22),),
                    ),
                    Container(
                      child: Text('Arial', style: TextStyle(fontFamily: 'Arial', fontSize: 22),),
                    ),
                    Container(
                      child: Text('Times', style: TextStyle(fontFamily: 'Times', fontSize: 22),),
                    )
                  ],
                ),
              ),
              // row 2
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text('18pt', style: TextStyle(fontSize: 24),),
                    ),
                    Container(
                      child: Text('Arial', style: TextStyle(fontFamily: 'Arial', fontSize: 24),),
                    ),
                    Container(
                      child: Text('Times', style: TextStyle(fontFamily: 'Times', fontSize: 24),),
                    )
                  ],
                ),
              ),
              // row 3
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text('22pt', style: TextStyle(fontSize: 30),),
                    ),
                    Container(
                      child: Text('Arial', style: TextStyle(fontFamily: 'Arial', fontSize: 30),),
                    ),
                    Container(
                      child: Text('Times', style: TextStyle(fontFamily: 'Times', fontSize: 30),),
                    )
                  ],
                ),
              ),
              // row 4
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text('26pt', style: TextStyle(fontSize: 35),),
                    ),
                    Container(
                      child: Text('Arial', style: TextStyle(fontFamily: 'Arial', fontSize: 35),),
                    ),
                    Container(
                      child: Text('Times', style: TextStyle(fontFamily: 'Times', fontSize: 35),),
                    )
                  ],
                ),
              ),
              // row 5
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text('30pt', style: TextStyle(fontSize: 40),),
                    ),
                    Container(
                      child: Text('Arial', style: TextStyle(fontFamily: 'Arial', fontSize: 40),),
                    ),
                    Container(
                      child: Text('Times', style: TextStyle(fontFamily: 'Times', fontSize: 40),),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text('40pt', style: TextStyle(fontSize: 54),),
                    ),
                    Container(
                      child: Text('Arial', style: TextStyle(fontFamily: 'Arial', fontSize: 54),),
                    ),
                    Container(
                      child: Text('Times', style: TextStyle(fontFamily: 'Times', fontSize: 54),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
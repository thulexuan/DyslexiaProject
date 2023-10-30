import 'package:flutter/material.dart';

class TestMirrorPage extends StatefulWidget {
  const TestMirrorPage({Key? key}) : super(key: key);

  @override
  State<TestMirrorPage> createState() => _TestMirrorPageState();
}

class _TestMirrorPageState extends State<TestMirrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Mirror Page'),),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 730,
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.volume_up, size: 40,)
            ),
            SizedBox(height: 20,),
            Text('d', style: TextStyle(fontSize: 24, fontFamily: 'Arial'),),
            SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('d', style: TextStyle(fontSize: 24, fontFamily: 'Arial')),
                Text('b', style: TextStyle(fontSize: 24, fontFamily: 'Arial')),
                Text('p', style: TextStyle(fontSize: 24, fontFamily: 'Arial')),
                Text('d', style: TextStyle(fontSize: 24, fontFamily: 'Times New Roman')),
                Text('b', style: TextStyle(fontSize: 24, fontFamily: 'Times New Roman')),
                Text('p', style: TextStyle(fontSize: 24, fontFamily: 'Times New Roman'))
              ],
            ),
            SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('d', style: TextStyle(fontSize: 36, fontFamily: 'Arial')),
                Text('b', style: TextStyle(fontSize: 36, fontFamily: 'Arial')),
                Text('p', style: TextStyle(fontSize: 36, fontFamily: 'Arial')),
                Text('d', style: TextStyle(fontSize: 36, fontFamily: 'Times New Roman')),
                Text('b', style: TextStyle(fontSize: 36, fontFamily: 'Times New Roman')),
                Text('p', style: TextStyle(fontSize: 36, fontFamily: 'Times New Roman'))
              ],
            )
          ],
        )
      ),
    );
  }
}

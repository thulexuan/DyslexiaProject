import 'package:flutter/material.dart';

class TestSpacing extends StatelessWidget {
  const TestSpacing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Spacing with different values'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('14pt, 0, 7, 14, 20%', style: TextStyle(color: Colors.red),),
                      Text('Arial', style: TextStyle(fontSize: 19, letterSpacing: 0),),
                      Text('Arial', style: TextStyle(fontSize: 19, letterSpacing: 1.5),),
                      Text('Arial', style: TextStyle(fontSize: 19, letterSpacing: 3),),
                      Text('Arial', style: TextStyle(fontSize: 19, letterSpacing: 4),),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('18pt, 0, 7, 14, 20%', style: TextStyle(color: Colors.red),),
                      Text('Times', style: TextStyle(fontSize: 24, letterSpacing: 0),),
                      Text('Times', style: TextStyle(fontSize: 24, letterSpacing: 2),),
                      Text('Times', style: TextStyle(fontSize: 24, letterSpacing: 3.5),),
                      Text('Times', style: TextStyle(fontSize: 24, letterSpacing: 5),),
                    ],
                  )
                ],
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('22pt, 0, 7, 14, 20%', style: TextStyle(color: Colors.red),),
                  Text('Arial', style: TextStyle(fontSize: 30, letterSpacing: 0),),
                  Text('Arial', style: TextStyle(fontSize: 30, letterSpacing: 2),),
                  Text('Arial', style: TextStyle(fontSize: 30, letterSpacing: 4),),
                  Text('Arial', style: TextStyle(fontSize: 30, letterSpacing: 6),),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('26pt, 0, 7, 14, 20%', style: TextStyle(color: Colors.red),),
                  Text('Times', style: TextStyle(fontSize: 35, letterSpacing: 0),),
                  Text('Times', style: TextStyle(fontSize: 35, letterSpacing: 2.5),),
                  Text('Times', style: TextStyle(fontSize: 35, letterSpacing: 5),),
                  Text('Times', style: TextStyle(fontSize: 35, letterSpacing: 7),),
                ],
              )
            ],
          ),
        ],
      ),

    );
    // return Scaffold(
    //   appBar: AppBar(title: Text('Spacing with different values'),),
    //   body: Row(
    //     children: [
    //       SizedBox(width: 100,),
    //       Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   SizedBox(height: 20,),
    //                   Text('14pt, 0, 20, 40, 60%', style: TextStyle(color: Colors.red),),
    //                   Text('xe đạp', style: TextStyle(fontSize: 19, wordSpacing: 0, fontFamily: 'Arial'),),
    //                   Text('xe đạp', style: TextStyle(fontSize: 19, wordSpacing: 4, fontFamily: 'Arial'),),  //20
    //                   Text('xe đạp', style: TextStyle(fontSize: 19, wordSpacing: 8, fontFamily: 'Arial'),), // 42
    //                   Text('xe đạp', style: TextStyle(fontSize: 19, wordSpacing: 12, fontFamily: 'Arial'),), // 63
    //                   SizedBox(height: 30,),
    //                   Text('18pt, 0, 20, 40, 60%', style: TextStyle(color: Colors.red),),
    //                   Text('xe đạp', style: TextStyle(fontSize: 24, wordSpacing: 0, fontFamily: 'Arial'),),
    //                   Text('xe đạp', style: TextStyle(fontSize: 24, wordSpacing: 5, fontFamily: 'Arial'),),  //20
    //                   Text('xe đạp', style: TextStyle(fontSize: 24, wordSpacing: 10, fontFamily: 'Arial'),), // 42
    //                   Text('xe đạp', style: TextStyle(fontSize: 24, wordSpacing: 15, fontFamily: 'Arial'),), // 63
    //                   SizedBox(height: 30,),
    //                   Text('22pt, 0, 20, 40, 60%', style: TextStyle(color: Colors.red),),
    //
    //                   Text('xe đạp', style: TextStyle(fontSize: 30, wordSpacing: 0, fontFamily: 'Arial'),),
    //                   Text('xe đạp', style: TextStyle(fontSize: 30, wordSpacing: 6, fontFamily: 'Arial'),),  //20
    //                   Text('xe đạp', style: TextStyle(fontSize: 30, wordSpacing: 12, fontFamily: 'Arial'),), // 42
    //                   Text('xe đạp', style: TextStyle(fontSize: 30, wordSpacing: 18, fontFamily: 'Arial'),), // 63
    //                   SizedBox(height: 30,),
    //                   Text('26pt, 0, 20, 40, 60%', style: TextStyle(color: Colors.red),),
    //
    //                   Text('xe đạp', style: TextStyle(fontSize: 35, wordSpacing: 0, fontFamily: 'Arial'),),
    //                   Text('xe đạp', style: TextStyle(fontSize: 35, wordSpacing: 7, fontFamily: 'Arial'),),
    //                   Text('xe đạp', style: TextStyle(fontSize: 35, wordSpacing: 14, fontFamily: 'Arial'),),
    //                   Text('xe đạp', style: TextStyle(fontSize: 35, wordSpacing: 21, fontFamily: 'Arial'),),
    //                 ],
    //               ),
    //     ],
    //   )
    //
    // );
  }
}

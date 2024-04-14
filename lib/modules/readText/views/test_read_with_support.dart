import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/readText/views/read_each_para_with_meaning.dart';
import 'package:dyslexia_project/modules/readText/views/read_each_paragraph_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Test extends StatefulWidget {

  String text;

  Test({
    required this.text
});

  @override
  State<Test> createState() => _TestState();
}


class _TestState extends State<Test> {

  late List<String> paragraphListTemp;
  List<String> paragraphList = [];

  List<dynamic> errorWords = [];

  void processText() {
    setState(() {
      paragraphListTemp = widget.text.split('*');
    });

    for (int i = 0; i < paragraphListTemp.length; i++) {
      if (paragraphListTemp[i].length > 1) {
        setState(() {
          paragraphList.add(paragraphListTemp[i]);
        });
      }
    }
  }

  Future<void> getErrorWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: prefs.getString('email')).get();

    final Object? data = snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    setState(() {
      errorWords = data != null && data is Map<String, dynamic>
          ? data['errorWords']
          : [] ;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processText();
    getErrorWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: PageView.builder(
                        itemCount: paragraphList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // int i = (index / 2).toInt();
                          return ReadEachParagraphPage(paragraph: paragraphList[index], wordsList: paragraphList[index].split(' '), errorWords: errorWords,);
                        },

                    )
                  ),
                ],
              ),
            ),
          ),
          // some buttons here
          // Container(
          //   height: 60,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         width: 56,
          //         height: 56,
          //         decoration: BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.circular(28)
          //         ),
          //         child: GestureDetector(
          //           onTap: () {
          //           },
          //           child: Icon(Icons.image, color: Colors.white,),
          //         ),
          //       ),
          //       SizedBox(width: 20,),
          //       Container(
          //         width: 56,
          //         height: 56,
          //         decoration: BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.circular(28)
          //         ),
          //         child: GestureDetector(
          //           onTap: () {
          //           },
          //           child: Icon(Icons.headphones, color: Colors.white,),
          //         ),
          //       ),
          //       SizedBox(width: 20,),
          //       Container(
          //         width: 56,
          //         height: 56,
          //         decoration: BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.circular(28)
          //         ),
          //         child: GestureDetector(
          //           onTap: () {
          //           },
          //           child: Icon(Icons.format_bold, color: Colors.white,),
          //         ),
          //       ),
          //       SizedBox(width: 20,),
          //       Container(
          //         width: 56,
          //         height: 56,
          //         decoration: BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.circular(28)
          //         ),
          //         child: GestureDetector(
          //           onTap: () {
          //           },
          //           child: Icon(Icons.format_underline, color: Colors.white,),
          //         ),
          //       ),
          //       SizedBox(width: 20,),
          //       Container(
          //         width: 56,
          //         height: 56,
          //         decoration: BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.circular(28)
          //         ),
          //         child: GestureDetector(
          //           onTap: () {
          //           },
          //           child: Icon(Icons.format_italic, color: Colors.white,),
          //         ),
          //       ),
          //       SizedBox(width: 20,),
          //       Container(
          //         width: 56,
          //         height: 56,
          //         decoration: BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.circular(28)
          //         ),
          //         child: GestureDetector(
          //           onTap: () {
          //           },
          //           child: Icon(Icons.refresh, color: Colors.white,),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EachWord extends StatefulWidget {
  // const EachWord({Key? key}) : super(key: key);

  String word;
  String image_url;

  EachWord({
    required this.word,
    required this.image_url
});

  @override
  State<EachWord> createState() => _EachWordState();
}

class _EachWordState extends State<EachWord> {
  final controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.word;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          widget.image_url != '' ? Container(
            width: 20,
            height: 20,
            child: Image.network(widget.image_url),
          ) : Container(
            width: 20,
            height: 20,
          ),
          Text(
            widget.word,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

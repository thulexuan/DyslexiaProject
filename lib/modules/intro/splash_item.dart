import 'package:flutter/material.dart';

class SplashItem extends StatelessWidget {

  final String title;
  final String body;
  final String imageUrl;

  SplashItem({
    required this.title,
    required this.body,
    required this.imageUrl
});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width / 1.5,
            child: Image.asset('assets/images/' + imageUrl, fit: BoxFit.contain,),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Text(title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(body, style: TextStyle(fontSize: 24,), textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}

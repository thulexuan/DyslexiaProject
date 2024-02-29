import 'package:flutter/material.dart';

class SignInOption extends StatelessWidget {

  final String image_path;

  SignInOption({
    required this.image_path
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        'assets/images/' + image_path,
        height: MediaQuery.of(context).size.height / 15,
      ),
    );
  }
}

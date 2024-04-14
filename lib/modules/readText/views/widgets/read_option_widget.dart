import 'package:dyslexia_project/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadOptionWidget extends StatelessWidget {

  final String description;
  final Icon icon;

  ReadOptionWidget({
    required this.description,
    required this.icon
});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        width: orientation == Orientation.landscape ? MediaQuery.of(context).size.width / 4 : MediaQuery.of(context).size.height / 4,
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 253, 208, 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              Container(
                  padding: EdgeInsets.all(0),
                  child: Text(description, textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium)
              ),
            ],
          ),
      ),
    );
  }
}

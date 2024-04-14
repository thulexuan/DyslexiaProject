import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../exam_collection_page.dart';

class ExamCollectionByClassItem extends StatelessWidget {

  String classLevel;
  ExamCollectionByClassItem({
    required this.classLevel
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExamCollectionPage(classLevel: 'Lớp $classLevel',)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade200,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3), // Shadow position (x, y)
              blurRadius: 5, // Spread of the shadow
              spreadRadius: 2, // Extends the shadow
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            leading: const Icon(Icons.folder_copy),
            title: Text('Lớp $classLevel', style: Theme.of(context).textTheme.bodyLarge,),
          ),
        ),
      ),
    );
  }
}

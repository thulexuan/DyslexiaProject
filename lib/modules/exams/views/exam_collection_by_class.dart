import 'package:dyslexia_project/modules/exams/views/component/exam_collection_by_class_item.dart';
import 'package:flutter/material.dart';

class ExamCollectionByClassPage extends StatelessWidget {
  const ExamCollectionByClassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(title: Text('Đọc hiểu', style: Theme.of(context).textTheme.labelSmall,),
      toolbarHeight: MediaQuery.of(context).size.height / 12,),
      body: GridView.count(
        padding: const EdgeInsets.all(30.0),
        crossAxisCount: orientation == Orientation.portrait ? 2 : 2,
        childAspectRatio: 5 / 1,
        crossAxisSpacing: 100,
        mainAxisSpacing: 30,
        children: List.generate(2, (index) {
          return ExamCollectionByClassItem(classLevel: (index + 1).toString(),);
        }),
      ),
    );
  }
}

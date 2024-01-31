import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoneProcessDetailPage extends StatefulWidget {
   DoneProcessDetailPage({Key? key, required this.examCode, required this.doneProcesses}) : super(key: key);

  String examCode;
  List<dynamic> doneProcesses;

  @override
  State<DoneProcessDetailPage> createState() => _DoneProcessDetailPageState();
}

class _DoneProcessDetailPageState extends State<DoneProcessDetailPage> {

  var seriesList = <Data>[];


  @override
  void initState() {
    for (var doneProcess in widget.doneProcesses) {
      seriesList.add(Data(doneProcess['date'].toDate(), (doneProcess['score']*100).toInt()));
    }
    // seriesList.add(Data(widget.doneProcesses[0]['date'].toDate(), (widget.doneProcesses[0]['score']*100).toInt()));
    // seriesList.add(Data(DateTime(2024, 03, 12), int.parse("40")));
    print(seriesList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kết quả bài kiểm tra số ${widget.examCode}'),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: charts.TimeSeriesChart(_createSampleData(seriesList),
                    animate: false,
                    behaviors: [
                      // charts.SlidingViewport(),
                      charts.PanAndZoomBehavior(),
                    ],
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                    defaultRenderer: charts.LineRendererConfig(includePoints: true),
                    selectionModels: [
                      charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info,
                        changedListener: _onSelectionChanged,
                      ),
                  ],
                )
            ),
            const Text('Bấm vào từng điểm để xem chi tiết từng lần làm bài',
              style: TextStyle(fontWeight: FontWeight.bold,),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    );
  }

  List<charts.Series<Data, DateTime>> _createSampleData(List<Data> data) {
    return [
      charts.Series<Data, DateTime>(
        id: 'time',
        domainFn: (Data process, _) => process.time,
        measureFn: (Data process, _) => process.percent,
        data: data,
      )
    ];
  }

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    if (selectedDatum.isNotEmpty) {
      final datum = selectedDatum.first.datum;
      // final series = selectedDatum.first.series.displayName;
      final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(datum.time); // Adjust the date format as needed

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Chi tiết lần làm bài'),
            content: Text('Ngày làm: $formattedDate\n \nTỷ lệ đúng: ${datum.percent}%'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

}

class Data {
  final DateTime time;
  final int percent;

  Data(this.time, this.percent);
}
// import 'dart:async';
//
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class DataByURL extends StatefulWidget {
//   @override
//   _DataByURLState createState() => _DataByURLState();
// }
//
// class _DataByURLState extends State<DataByURL> {
//   List finalValues = [];
//   String c1R1 = "";
//   String c1R2 = "";
//   String c1R3 = "";
//   String c2R1 = "";
//   String c2R2 = "";
//   String c2R3 = "";
//   String c3R1 = "";
//   String c3R2 = "";
//   String c3R3 = "";
//   String factor = "";
//   String distortion = "";
//   String frequency = "";
//
//   bool? isDataLoaded;
//
//   Future getData() async {
//     List<String> value = [];
//     http.Response response =
//         await http.get(Uri.parse("https://scadaapp.azurewebsites.net/read"));
//
//     // print(response.body.length);
//     List<dynamic> listValues = [response.body];
//
//     // print(listValues[0][3]);
//     for (int i = 0; i < response.body.length; i++) {
//       debugPrint('loop');
//       if (listValues[0][i] != ",") {
//         value.add(listValues[0][i]);
//       } else {
//         finalValues.add(value.join());
//         //print(value.join());
//         value = [];
//       }
//       if (i == response.body.length - 1) {
//         finalValues.add(value.join());
//       }
//     }
//     c3R1 = finalValues[0];
//     c3R2 = finalValues[1];
//     c3R3 = finalValues[2];
//     c2R1 = finalValues[3];
//     c1R1 = finalValues[4];
//     c2R2 = finalValues[5];
//     c1R2 = finalValues[6];
//     c2R3 = finalValues[7];
//     c1R3 = finalValues[8];
//     distortion = finalValues[9];
//     factor = finalValues[10];
//     frequency = finalValues[11];
//     changeState();
//   }
//
//   bool isStopped = true;
//
//   void changeState() {
//     setState(() {
//       isDataLoaded = true;
//     });
//   }
//
//   void initState() {
//     super.initState();
//     isDataLoaded = false;
//     getData();
//   }
//
//   changeTimer() {
//     Timer.periodic(Duration(milliseconds: 500), (timer) {
//       if (isStopped) {
//         timer.cancel();
//       }
//       setState(() {
//         getData();
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // changeTimer();
//     return Scaffold(
//       body: isDataLoaded!
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'SCADA SYSTEM',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25,
//                       color: Colors.orange[800]),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 DataTable(
//                   headingTextStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                   columns: [
//                     DataColumn(
//                       label: Text('Phase'),
//                     ),
//                     DataColumn(
//                         label: Column(
//                       children: [Text('V L-N'), Text('(Volts)')],
//                     )),
//                     DataColumn(
//                       label: Column(
//                         children: [Text('V L-L'), Text('(Volts)')],
//                       ),
//                     ),
//                     DataColumn(
//                       label: Column(
//                         children: [Text('Current'), Text('(Amp)')],
//                       ),
//                     ),
//                   ],
//                   rows: [
//                     DataRow(
//                       cells: [
//                         DataCell(
//                           Text(
//                             'Red',
//                             style: TextStyle(
//                                 color: Colors.red, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         DataCell(
//                           Text('$c1R1'),
//                         ),
//                         DataCell(
//                           Text('$c2R1'),
//                         ),
//                         DataCell(
//                           Text('$c3R1'),
//                         ),
//                       ],
//                     ),
//                     DataRow(
//                       cells: [
//                         DataCell(
//                           Text(
//                             'Blue',
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         DataCell(
//                           Text('$c1R2'),
//                         ),
//                         DataCell(
//                           Text('$c2R2'),
//                         ),
//                         DataCell(
//                           Text('$c3R2'),
//                         ),
//                       ],
//                     ),
//                     DataRow(
//                       cells: [
//                         DataCell(
//                           Text(
//                             'Yellow',
//                             style: TextStyle(
//                                 color: Colors.yellow,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         DataCell(
//                           Text('$c1R3'),
//                         ),
//                         DataCell(
//                           Text('$c2R3'),
//                         ),
//                         DataCell(
//                           Text('$c3R3'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Power Factor'),
//                           Text('$factor'),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Harmonic Distortion %'),
//                           Text('$distortion'),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Frequency (Hz)'),
//                           Text('$frequency'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 35),
//                 (isStopped)
//                     ? MaterialButton(
//                         onPressed: () {
//                           changeTimer();
//                           isStopped = false;
//                         },
//                         child: Text('START'),
//                         color: Colors.grey[900],
//                       )
//                     : MaterialButton(
//                         onPressed: () {
//                           isStopped = true;
//                         },
//                         child: Text('STOP'),
//                         color: Colors.red,
//                       ),
//               ],
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }

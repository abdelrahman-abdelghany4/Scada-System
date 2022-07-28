import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:kdgaugeview/kdgaugeview.dart';

class RandomDataTable extends StatefulWidget {
  @override
  _RandomDataTableState createState() => _RandomDataTableState();
}

double c1R1 = 0.0;
double c1R2 = 0.0;
double c1R3 = 0.0;
double c2R1 = 0.0;
double c2R2 = 0.0;
double c2R3 = 0.0;
double c3R1 = 0.0;
double c3R2 = 0.0;
double c3R3 = 0.0;
double factor = 0.0;
double distortion = 0.0;
double frequency = 0.0;
bool isStopped = true;

class _RandomDataTableState extends State<RandomDataTable> {
  changeTimer() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (isStopped) {
        timer.cancel();
      }
      setState(() {
        c1R1 = double.parse(
            (Random().nextDouble() * (235 - 225) + 225).toStringAsFixed(1));
        c1R2 = double.parse(
            (Random().nextDouble() * (235 - 225) + 225).toStringAsFixed(1));
        c1R3 = double.parse(
            (Random().nextDouble() * (235 - 225) + 225).toStringAsFixed(1));
        c2R1 = double.parse(
            (Random().nextDouble() * (410 - 400) + 400).toStringAsFixed(1));
        c2R2 = double.parse(
            (Random().nextDouble() * (410 - 400) + 400).toStringAsFixed(1));
        c2R3 = double.parse(
            (Random().nextDouble() * (410 - 400) + 400).toStringAsFixed(1));
        c3R1 = double.parse(
            (Random().nextDouble() * (45 - 40) + 40).toStringAsFixed(1));
        c3R2 = double.parse(
            (Random().nextDouble() * (45 - 40) + 40).toStringAsFixed(1));
        c3R3 = double.parse(
            (Random().nextDouble() * (45 - 40) + 40).toStringAsFixed(1));
        factor = double.parse((Random().nextDouble()).toStringAsFixed(1));
        distortion = double.parse(
            (Random().nextDouble() * (40 - 30) + 30).toStringAsFixed(1));
        frequency = double.parse(
            (Random().nextDouble() * (50.0 - 49.0) + 49.0).toStringAsFixed(2));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // changeTimer();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 400,
                  height: 400,
                  padding: EdgeInsets.all(10),
                  child: KdGaugeView(
                    minSpeed: 0,
                    maxSpeed: c3R3,
                    speed: c1R2,
                    animate: true,
                    duration: Duration(seconds: 5),
                    alertSpeedArray: [40, 80, 90],
                    alertColorArray: [Colors.orange, Colors.indigo, Colors.red],
                    unitOfMeasurement: "km/h",
                    gaugeWidth: 20,
                    fractionDigits: 1,
                  ),
                )
              ],
            ),
            Text(
              'SCADA SYSTEM',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orange[800]),
            ),
            SizedBox(
              height: 50,
            ),
            DataTable(
              headingTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              columns: [
                DataColumn(
                  label: Text('Phase'),
                ),
                DataColumn(
                    label: Column(
                  children: [Text('V L-N'), Text('(Volts)')],
                )),
                DataColumn(
                  label: Column(
                    children: [Text('V L-L'), Text('(Volts)')],
                  ),
                ),
                DataColumn(
                  label: Column(
                    children: [Text('Current'), Text('(Amp)')],
                  ),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        'Red',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(
                      Text('$c1R1'),
                    ),
                    DataCell(
                      Text('$c2R1'),
                    ),
                    DataCell(
                      Text('$c3R1'),
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        'Blue',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(
                      Text('$c1R2'),
                    ),
                    DataCell(
                      Text('$c2R2'),
                    ),
                    DataCell(
                      Text('$c3R2'),
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        'Yellow',
                        style: TextStyle(
                            color: Colors.yellow, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(
                      Text('$c1R3'),
                    ),
                    DataCell(
                      Text('$c2R3'),
                    ),
                    DataCell(
                      Text('$c3R3'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Power Factor'),
                      Text('$factor'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Harmonic Distortion %'),
                      Text('$distortion'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Frequency (Hz)'),
                      Text('$frequency'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),
            (isStopped)
                ? MaterialButton(
                    onPressed: () {
                      changeTimer();
                      isStopped = false;
                    },
                    child: Text('START'),
                    color: Colors.grey[900],
                  )
                : MaterialButton(
                    onPressed: () {
                      isStopped = true;
                    },
                    child: Text('STOP'),
                    color: Colors.red,
                  ),
          ],
        ),
      ),
    );
  }
}

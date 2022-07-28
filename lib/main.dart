import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scada_system/dataScreenRandom.dart';
import 'package:scada_system/dataURL.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: RandomDataTable(),
    );
  }
}

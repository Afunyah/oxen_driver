import 'package:flutter/material.dart';
import 'package:oxen_driver/screens/init_page/init_page.dart';
import 'flutter_flow/flutter_flow_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'oxen driver',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InitPageWidget(),
    );
  }
}

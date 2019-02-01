import 'package:flutter/material.dart';
import 'package:yourly/pages/homepage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Yourly',
      theme: new ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.deepPurple,
      ),
      home: Homepage(),
    );
  }
}

import 'package:bootcamp_oua_f4/screens/add_screen.dart';
import 'package:bootcamp_oua_f4/screens/detail_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: addScreen(),
    );
  }
}

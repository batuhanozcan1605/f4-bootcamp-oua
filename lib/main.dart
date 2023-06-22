import 'package:bootcamp_oua_f4/screens/add_custom_food.dart';
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
      home:  AddCustomFood(),
    );
  }
}

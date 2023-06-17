import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FreezerSecreen extends StatefulWidget {
  const FreezerSecreen({Key? key}) : super(key: key);

  @override
  State<FreezerSecreen> createState() => _FreezerSecreenState();
}

class _FreezerSecreenState extends State<FreezerSecreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pekkıyak"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}

import 'package:bootcamp_oua_f4/widgets/food_card_dummy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dummy_data.dart';

class PantrySecreen extends StatefulWidget {
  const PantrySecreen({Key? key}) : super(key: key);

  @override
  State<PantrySecreen> createState() => _PantrySecreenState();
}

class _PantrySecreenState extends State<PantrySecreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("irem"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            foodCard("ekmek",Assets.tomato, false)
          ],
        ),
      ),
    );
  }
}

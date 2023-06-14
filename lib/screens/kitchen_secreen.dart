import 'package:flutter/material.dart';

class KitchenSecreen extends StatefulWidget {
  const KitchenSecreen({Key? key}) : super(key: key);

  @override
  State<KitchenSecreen> createState() => _KitchenSecreenState();
}

class _KitchenSecreenState extends State<KitchenSecreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(30.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wallet),
            SizedBox(width: 5),
            Text(
              'cep mutfak',
              style: TextStyle(fontFamily: 'VarelaRound', fontSize: 16),),
          ],
        ),),

        elevation: 0,
        toolbarHeight: 40,

      ),
      body: Center(
      ),



    );
  }
}
import 'package:flutter/material.dart';

class AddSecreen extends StatefulWidget {
  const AddSecreen({Key? key}) : super(key: key);

  @override
  State<AddSecreen> createState() => _AddSecreenState();
}

class _AddSecreenState extends State<AddSecreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4D818C),
        title: Container(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wallet),
              SizedBox(width: 5),
              Text(
                'cep mutfak',
                style: TextStyle(fontFamily: 'VarelaRound', fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      body: Center(
      ),



    );
  }
}
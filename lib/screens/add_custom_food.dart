import 'package:flutter/material.dart';

class AddCustomFood extends StatefulWidget {
  @override
  _AddCustomFoodState createState() => _AddCustomFoodState();
}

class _AddCustomFoodState extends State<AddCustomFood> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Container(
          child: Column(
            children: [
              Center(
                child: Image.network(
                  'https://nationaltoday.com/wp-content/uploads/2020/06/Soul-Food-1-1.jpg',
                  width: 150,
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ShoppingCartSecreen extends StatefulWidget {
  const ShoppingCartSecreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartSecreen> createState() => _ShoppingCartSecreenState();
}

class _ShoppingCartSecreenState extends State<ShoppingCartSecreen> {


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
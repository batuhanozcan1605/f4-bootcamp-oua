import 'package:flutter/material.dart';

class ShoppingCardScreen extends StatefulWidget {
  const ShoppingCardScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCardScreen> createState() => _ShoppingCardScreenState();
}

class _ShoppingCardScreenState extends State<ShoppingCardScreen> {
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
        child: ListView(
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3),
              ),
              title: Text('Onion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              trailing: Wrap(
                spacing: 10, // space between two icons
                children: <Widget>[
                  Icon(Icons.add_box_outlined, size: 30,color: Color(0xFF4D818C)), // icon-1
                  Icon(Icons.delete,size: 30,color: Color(0xFF4D818C),), // icon-2
                ],
              ),
            ),
            SizedBox(height: 20,),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3),
              ),
              title: Text('Tomato', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              trailing: Wrap(
                spacing: 10, // space between two icons
                children: <Widget>[
                  Icon(Icons.add_box_outlined, size: 30,color: Color(0xFF4D818C)), // icon-1
                  Icon(Icons.delete,size: 30,color: Color(0xFF4D818C),), // icon-2
                ],
              ),

            ),
            SizedBox(height: 20,),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3),
              ),
              title: Text('Milk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              trailing: Wrap(
                spacing: 10, // space between two icons
                children: <Widget>[
                  Icon(Icons.add_box_outlined, size: 30,color: Color(0xFF4D818C)), // icon-1
                  Icon(Icons.delete,size: 30,color: Color(0xFF4D818C),), // icon-2
                ],
              ),
            ),
            SizedBox(height: 20,),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3),
              ),
              title: Text('Bread', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              trailing: Wrap(
                spacing: 10, // space between two icons
                children: <Widget>[
                  Icon(Icons.add_box_outlined, size: 30,color: Color(0xFF4D818C)), // icon-1
                  Icon(Icons.delete,size: 30,color: Color(0xFF4D818C),), // icon-2
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

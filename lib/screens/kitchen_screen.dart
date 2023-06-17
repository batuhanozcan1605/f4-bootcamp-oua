import 'package:bootcamp_oua_f4/screens/freezer_screen.dart';
import 'package:bootcamp_oua_f4/screens/pantry_screen.dart';
import 'package:bootcamp_oua_f4/screens/recipe_secreen.dart';
import 'package:bootcamp_oua_f4/screens/tabbar_screen.dart';
import 'package:bootcamp_oua_f4/widgets/food_cards.dart';
import 'package:flutter/material.dart';

class KitchenSecreen extends StatefulWidget {
  const KitchenSecreen({Key? key}) : super(key: key);

  @override
  State<KitchenSecreen> createState() => _KitchenSecreenState();
}



class _KitchenSecreenState extends State<KitchenSecreen> {
  @override
  Widget build(BuildContext context) {
    //TabController = _tabController = TabController(length: 3, vsync: this),
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
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
          body: Container(
              child: TabBarScreen()),
        ),
      ),
    );
  }
}

import 'package:bootcamp_oua_f4/screens/kitchen/freezer_screen.dart';
import 'package:bootcamp_oua_f4/screens/kitchen/pantry_screen.dart';
import 'package:bootcamp_oua_f4/screens/recipe_screen.dart';
import 'package:bootcamp_oua_f4/screens/kitchen/tabbar_screen.dart';
import 'package:bootcamp_oua_f4/widgets/food_cards.dart';
import 'package:flutter/material.dart';

class KitchenScreen extends StatefulWidget {
  const KitchenScreen({Key? key}) : super(key: key);

  @override
  State<KitchenScreen> createState() => _KitchenScreenState();
}


class _KitchenScreenState extends State<KitchenScreen> {
  @override
  Widget build(BuildContext context) {
    //TabController = _tabController = TabController(length: 3, vsync: this),
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
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
          body: const TabBarScreen(),
        ),
      ),
    );
  }
}
import 'package:bootcamp_oua_f4/screens/kitchen/fridge_screen.dart';
import 'package:bootcamp_oua_f4/screens/kitchen/pantry_screen.dart';
import 'package:flutter/material.dart';
import 'freezer_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {

  TabBar get _tabBar => TabBar(
    labelPadding: EdgeInsets.only(left: 0, right: 0, top: 10),

    indicatorColor: Color(0xFF4D818C),
    indicator: UnderlineTabIndicator(
      borderRadius: BorderRadius.circular(60), // Creates border
      borderSide: BorderSide(
        width: 15.0,
        color: Color(0xFF4D818C),
      ),

      insets: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
    ),

    labelColor: Color(0xffffffff),
    //<-- selected text color
    unselectedLabelColor: Color(0xFF4D818C),

    tabs: [
      Tab(
          child: Text(
            "Fridge",
            style: TextStyle(fontSize: 15),
          )),
      Tab(
          child: Text(
            "Pantry",
            style: TextStyle(fontSize: 15),
          )),
      Tab(
          child: Text(
            "Freezer",
            style: TextStyle(fontSize: 15),
          )),
    ],
  );

  TabBarView get _tabBarView => TabBarView(
    children: [FridgeScreen(), PantryScreen(), FreezerScreen()],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: TextField(
                    onChanged: (value) => {},
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffffffff),
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Container(
                  height: 45.0,
                  alignment: Alignment.center,
                  child: _tabBar,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                      bottom: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 1.0,
                        offset:
                        Offset(0, 0), // shadow direction: bottom right
                      )
                    ],
                  ),
                ),
                Container(
                    height: 80.0,
                    child: _tabBarView
                ),
                /*Material(
                        elevation: 5,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(0),
                          bottom: Radius.circular(30),
                        ),
                        color: Colors.white,
                        child: Container(
                          height: 45.0,
                          alignment: Alignment.center,
                          child: _tabBar,
                        ),
                      ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
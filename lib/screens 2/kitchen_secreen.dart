import 'package:bootcamp_oua_f4/screens/recipe_secreen.dart';
import 'package:bootcamp_oua_f4/widgets/prodcut.dart';
import 'package:bootcamp_oua_f4/widgets/product_cards.dart';
import 'package:flutter/material.dart';

class KitchenSecreen extends StatefulWidget {
  const KitchenSecreen({Key? key}) : super(key: key);

  @override
  State<KitchenSecreen> createState() => _KitchenSecreenState();
}

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
          "Refrigerator",
          style: TextStyle(fontSize: 15),
        )),
        Tab(
            child: Text(
          "Celler",
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
      children: [KitchenSecreen(), RecipeSecreen(), KitchenSecreen()],
    );

class _KitchenSecreenState extends State<KitchenSecreen> {
  @override
  Widget build(BuildContext context) {
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
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Material(
                        elevation: 5,
                        child: TextField(
                          onChanged: (value) => {},
                          decoration: const InputDecoration(
                            border: InputBorder.none,

                            filled: true,
                            //<-- SEE HERE

                            fillColor: Color(0xffffffff),

                            labelText: 'Search',

                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    Material(
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
                    ),
                    //ProductCard(backgroundColor: Colors.black, name: "irem"),
                    //ProductCard(backgroundColor: Colors.black, name: "pekkıyak"),
                    _tabBarView
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    TabBarView(
      children: [
        KitchenSecreen(),
      ],
    );
  }
}

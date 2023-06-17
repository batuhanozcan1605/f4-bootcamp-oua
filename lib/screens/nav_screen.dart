import 'package:bootcamp_oua_f4/screens/add_screen.dart';
import 'package:bootcamp_oua_f4/screens/kitchen_screen.dart';
import 'package:bootcamp_oua_f4/screens/recipe_secreen.dart';
import 'package:bootcamp_oua_f4/screens/shoppingcart_screen.dart';
//import 'package:bootcamp_oua_f4/widgets/prodcut.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  int currentindex = 0;
  final screens = [
    KitchenSecreen(),
    //Product(),
    AddSecreen(),
    ShoppingCardScreen(),
    // Aşağıdaki ekranlar hazırlandıkça yukarıdaki Scaffold'ların yerine yazılacak.
    /*KitchenScreen(),
    AddScreen(),
    RecipeScreen(),
    ShoppingCartScreen(),*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentindex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
              )
            ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF4D818C),
            unselectedItemColor: Color(0xFF4D818C).withOpacity(0.5),
            currentIndex: currentindex,
            onTap: (index) => setState(() => currentindex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.kitchen, size: 35),
                label: 'Kitchen',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined, size: 35,),
                label: 'Recipe',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle, size: 35),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt, size: 35),
                label: 'Shopping Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
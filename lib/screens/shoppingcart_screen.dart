import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

class ShoppingCardScreen extends StatefulWidget {

  @override
  State<ShoppingCardScreen> createState() => _ShoppingCardScreenState();
}

class _ShoppingCardScreenState extends State<ShoppingCardScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  void _showSnackBar(BuildContext context, document) {
    final snackBar = SnackBar(action: SnackBarAction(
        label: 'Undo',
        onPressed: (){
          DataService().undoAdd();
        }),
      content: Text("${document['name']} has been added to your Kitchen.",
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      backgroundColor: const Color(0xFF013440),);
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4D818C),
          title: SvgPicture.asset('assets/images/appbar_logo.svg'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text("My Shopping Cart",
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 22,
                  color: Color(0xff013440),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Row(),
            const Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0),
              child: Divider(thickness: 2.0,),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(uid).collection('shoppingCart')
                  .where('name', isNull: false).get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var foods = snapshot.data!.docs;
                  if (foods.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: foods.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot food = foods[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                visualDensity: const VisualDensity(vertical: -4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(width: 1, color: Constants.tPrimaryColor),
                                ),
                                title: Text(food['name'], style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF4D818C)),),
                                trailing: Wrap(
                                  spacing: 2, // space between two icons
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: () async {
                                          await DataService().addFoodFromCart(food.id);
                                            setState(() {
                                              DataService().deleteFoodFromCart(food.id);
                                            });
                                            _showSnackBar(context, food);
                                    },
                                        icon: const Icon(Icons.add_box_outlined, size: 30,color: Color(0xFF4D818C))), // icon-1
                                    IconButton(
                                        onPressed: (){
                                          setState(() {
                                            DataService().deleteFoodFromCart(food.id);
                                          });
                                    },
                                        icon: const Icon(Icons.delete,size: 30,color: Color(0xFF4D818C),)), // icon-2
                                  ],
                                ),

                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center();
                  }
              } else {
                  return const Center(child: Text(""));
                }
              }),
          ],
        ),
      ),
    );
  }

}

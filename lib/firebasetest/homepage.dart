import 'package:bootcamp_oua_f4/firebasetest/category_model.dart';
import 'package:bootcamp_oua_f4/firebasetest/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categories = [];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              categories = await bringCategories();
              Category category = categories[0];
              print(category.category_name);
              getFoodsFromCategory();
            },
            child: Text("Data Getir")),
      ),
    );
  }

  Future<List> hepsiniGetir() async {
    categories = await bringCategories();
    return categories;
  }
}

Future<List<Category>> bringCategories() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('categories').get();
  print("bring return öncesi");
  return querySnapshot.docs.map((e) => Category.fromMap(e.data())).toList();
}

Future<void> getData() async {
  FirebaseFirestore.instance
      .collection('categories')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc["category_name"]);
    });
  });
}

Future<void> getFoodsFromCategory() async {
  FirebaseFirestore.instance
      .collection('foods')
      .where('category_id', isEqualTo: 1).where('place', isEqualTo: "d")
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc["name"]);
    });
  });
}
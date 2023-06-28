import 'package:bootcamp_oua_f4/models/FoodModel.dart';
import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:bootcamp_oua_f4/widgets/food_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodsScreen extends StatefulWidget {
  int categoryId;

  FoodsScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {


  bool isSelected = false;
  List<String> _selectedDocumentIds = [];

  void toggleCardSelection(food) {
    String documentId = food.id;

    setState(() {
      if (_selectedDocumentIds.contains(documentId)) {
        _selectedDocumentIds.remove(documentId);
      } else {
        _selectedDocumentIds.add(documentId);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('foods').where('categoryId', isEqualTo: widget.categoryId).get(),
      builder: (BuildContext context, snapshot) {
    if (snapshot.hasData) {
      List<QueryDocumentSnapshot> foods = snapshot.data!.docs;

      return GridView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: foods.length,
          itemBuilder: (context, index) {
            DocumentSnapshot food = foods[index];
            bool isSelected = _selectedDocumentIds.contains(food.id);

            return GestureDetector(
                onTap: (){
                  toggleCardSelection(food);
                },
                child: foodCard(food, isSelected));
          }
      );
    } else {
      return const Center(child: Text(""),);
    }
    },

    );
  }
}

import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:bootcamp_oua_f4/widgets/food_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodsScreen extends ConsumerWidget {
  int categoryId;

  FoodsScreen({Key? key, required this.categoryId}) : super(key: key);


  bool isSelected = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodsRepo = ref.watch(foodsProvider);

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('foods').where(
          'categoryId', isEqualTo: categoryId).get(),
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

                return FoodCard(food: food, inKitchen: false,);
              }
          );
        } else {
          return const Center(child: Text(""),);
        }
      },

    );
  }
}

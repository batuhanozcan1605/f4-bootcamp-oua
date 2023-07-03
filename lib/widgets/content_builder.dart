import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:bootcamp_oua_f4/widgets/food_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/constants.dart';

class ContentBuilder extends ConsumerStatefulWidget {
  int categoryId;
  String categoryName;
  String place;

  ContentBuilder(this.categoryId, this.categoryName, this.place);

  @override
  ContentBuilderState createState() => ContentBuilderState();
}

class ContentBuilderState extends ConsumerState<ContentBuilder> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users').doc(Constants.uid).collection('kitchen')
            .where('categoryId', isEqualTo: widget.categoryId)
            .where('place', isEqualTo: widget.place)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var foods = snapshot.data!.docs;
            if (foods.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 10),
                    child: Text(
                      widget.categoryName,
                      style: const TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: Color(0xff013440),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot food = foods[index];

                          return FoodCard(food: food, inKitchen: true);
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                      )
                  ),
                ],
              );
            } else {
              return Center();
            }
          } else {
            return const Center(child: Text(""));
          }
        });
  }
}

import 'package:bootcamp_oua_f4/main.dart';
import 'package:bootcamp_oua_f4/models/FoodModel.dart';
import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:bootcamp_oua_f4/widgets/food_cards.dart';
import 'package:flutter/material.dart';

class FoodsScreen extends StatelessWidget {
  int categoryId;

  FoodsScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
      future: DataService().getFoods(categoryId),
      builder: (BuildContext context,
      AsyncSnapshot<List<Food>> snapshot) {
    if (snapshot.hasData) {
      var foodList = snapshot.data;
      return GridView.builder(
          padding: const EdgeInsets.all(5),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: foodList?.length,
          itemBuilder: (context, index) {
            var food = foodList![index];
            return GestureDetector(
                onTap: (){
                },
                child: foodCard(food)
            );
          }
      );
    } else {
      return const Center(child: Text(""),);
    }
    },

    );
  }
}

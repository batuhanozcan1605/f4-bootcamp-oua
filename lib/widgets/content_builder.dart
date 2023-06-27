import 'package:bootcamp_oua_f4/models/FoodModel.dart';
import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:bootcamp_oua_f4/widgets/food_cards.dart';
import 'package:flutter/material.dart';

class ContentBuilder extends StatefulWidget {
  int categoryId;
  String categoryName;
  String place;

  ContentBuilder(this.categoryId, this.categoryName, this.place);

  @override
  State<ContentBuilder> createState() => _ContentBuilderState();
}

class _ContentBuilderState extends State<ContentBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
        future: DataService().showFoodInKitchen(widget.categoryId, widget.place),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var foods = snapshot.data;
            if (foods!.isNotEmpty) {
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
                        var food =  foods[index];
                          return GestureDetector(
                            onTap: () {

                            },
                            child: foodCard(food));
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

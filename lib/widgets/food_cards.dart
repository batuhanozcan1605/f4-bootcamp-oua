import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:bootcamp_oua_f4/repositories/imageurl_repo.dart';
import 'package:bootcamp_oua_f4/screens/detail_screen.dart';
import 'package:bootcamp_oua_f4/widgets/shelftime_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants/constants.dart';

class FoodCard extends ConsumerWidget {
  final food;
  final inKitchen;
  const FoodCard({super.key, required this.food, required this.inKitchen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodsRepo = ref.watch(foodsProvider);
    final imageUrlRepo = ref.watch(imageUrlProvider);
    final imageUrl = imageUrlRepo.imageUrls[food['image']];
    bool isSelected = foodsRepo.selectedDocumentIds.contains(food.id);
    //final imageUrl = imageUrls[food['image']];
    print("DEBUG2 $imageUrl");
    print("DEBUG3 ${food['name']}");
    return GestureDetector(
      onTap: () {
        ref
            .read(foodsProvider)
            .toggleFoodSelection(food, inKitchen);
      },
      onLongPress: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DetailScreen(food: food, imageUrl: imageUrl,)));
      },
      child: Card(
        margin: const EdgeInsets.all(7),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          fit: StackFit.expand,
          children: [
            imageUrl != null
                ? CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl: imageUrl)
                : SpinKitRing(
                    color: Constants.tPrimaryColor,
                    size: 50.0,
                    lineWidth: 2.0,
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 0.25,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: isSelected
                        ? Constants.tselectedItemColor
                        : Colors.white,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        food['name'],
                        style: Constants.ProductTitle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
           inKitchen ? ShelfTimeCounter(food: food) : Center()
          ],
        ),
      ),
    );
  }
}

import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:bootcamp_oua_f4/repositories/imageurl_repo.dart';
import 'package:bootcamp_oua_f4/widgets/shelftime_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/constants.dart';

class FoodCard extends ConsumerStatefulWidget {
  final food;
  final inKitchen;
  const FoodCard({super.key, required this.food, required this.inKitchen});

  @override
  FoodCardState createState() => FoodCardState();
}

class FoodCardState extends ConsumerState<FoodCard> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final foodsRepo = ref.watch(foodsProvider);
    final imageUrlRepo = ref.watch(imageUrlProvider);
    final imageUrls = imageUrlRepo.imageUrls;
    bool isSelected = foodsRepo.selectedDocumentIds.contains(widget.food.id);



    return GestureDetector(
      onTap: () {
        ref.read(foodsProvider).toggleFoodSelection(widget.food, widget.inKitchen);
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
            CachedNetworkImage(
                fit: BoxFit.fitHeight,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: imageUrls[widget.food['image']]!),
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
                        widget.food['name'],
                        style: Constants.ProductTitle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            widget.inKitchen ? ShelfTimeCounter(food: widget.food) : Center()
          ],
        ),
      ),
    );
  }
}
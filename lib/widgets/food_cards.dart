import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:bootcamp_oua_f4/repositories/imageurl_repo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/constants.dart';
import '../services/data_service.dart';

class FoodCard extends ConsumerStatefulWidget {
  final food;
  const FoodCard({super.key, required this.food});

  @override
  FoodCardState createState() => FoodCardState();
}

class FoodCardState extends ConsumerState<FoodCard> {
  @override
  Widget build(BuildContext context) {
    final foodsRepo = ref.watch(foodsProvider);
    final imageUrlRepo = ref.watch(imageUrlProvider);
    final imageUrls = imageUrlRepo.imageUrls;
    bool isSelected = foodsRepo.selectedDocumentIds.contains(widget.food.id);

    return GestureDetector(
      onTap: () {
        ref.read(foodsProvider).toggleFoodSelection(widget.food);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: imageUrls[widget.food['image']]!),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 25,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: isSelected
                      ? Constants.tselectedItemColor
                      : Colors.white.withOpacity(0.7),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      widget.food['name'],
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 12,
                        color: Color(0xff013440),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
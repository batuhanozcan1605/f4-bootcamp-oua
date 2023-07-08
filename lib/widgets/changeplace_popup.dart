import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../repositories/kitchen_state.dart';

class ChangePlaceWidget extends ConsumerWidget {
  const ChangePlaceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final foodsRepo = ref.watch(foodsProvider);
    final kitchenState = ref.watch(buttonTapProvider.notifier);
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.kitchen_outlined, color: Constants.tselectedItemColor,),
                  onPressed: () {
                    foodsRepo.tapInKitchen = false;
                    ref.read(foodsProvider).updatePlace('place', 'b');
                    kitchenState.setButtonTap();
                    ref.read(foodsProvider).cancelTapInKitchen();
                    Navigator.pop(context);
                  },
                ),
                Text("Fridge", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Constants.tselectedItemColor,
                ),),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.dashboard_outlined,color: Constants.tselectedItemColor),
                  onPressed: () {
                    foodsRepo.tapInKitchen = false;
                    ref.read(foodsProvider).updatePlace('place', 'k');
                    kitchenState.setButtonTap();
                    ref.read(foodsProvider).cancelTapInKitchen();
                    Navigator.pop(context);
                  },
                ),
                Text("Pantry", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Constants.tselectedItemColor,
                ),),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.icecream_outlined, color: Constants.tselectedItemColor,),
                  onPressed: () {
                    foodsRepo.tapInKitchen = false;
                    ref.read(foodsProvider).updatePlace('place', 'd');
                    kitchenState.setButtonTap();
                    ref.read(foodsProvider).cancelTapInKitchen();
                    Navigator.pop(context);
                  },
                ),
                Text("Freeezer", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Constants.tselectedItemColor,
                ),),
              ],
            ),
          ),

        ],
      ),
    );;
  }
}

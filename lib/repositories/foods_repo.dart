import 'package:flutter/material.dart';
import '../models/FoodModel.dart';
import '../services/data_service.dart';

class FoodsRepo extends ChangeNotifier {

  Map<int, List> foods = {
    1 : [],
    2 : [],
  };

  final DataService dataService;
  FoodsRepo(this.dataService);

  Future<void> fetchFoods(categoryId) async {
    foods[categoryId] = await dataService.getFoods(categoryId);
    notifyListeners();
  }

}
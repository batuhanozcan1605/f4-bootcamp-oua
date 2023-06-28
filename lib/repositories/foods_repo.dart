import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/data_service.dart';

class FoodsRepo extends ChangeNotifier {

  //bool isSelected = false;
  List<String> selectedDocumentIds = [];

  /*Future<void> fetchFoods(categoryId) async {
    foods[categoryId] = await dataService.getFoods(categoryId);
    notifyListeners();
  }  */ // kullanım dışı

  void toggleFoodSelection(food) {
    String documentId = food.id;
    if (selectedDocumentIds.contains(documentId)) {
      selectedDocumentIds.remove(documentId);
    } else {
      selectedDocumentIds.add(documentId);
    }

    notifyListeners();
  }



}

final foodsProvider = ChangeNotifierProvider((ref) => FoodsRepo());
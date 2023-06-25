import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/CategoryModel.dart';

class CategoriesRepo extends ChangeNotifier {

  List<Category> categories = [];

  final DataService dataService;
  CategoriesRepo(this.dataService);

  Future<void> fetchCategories() async {
    categories = await DataService().getCategories();
    notifyListeners();
  }
}

final categoriesProvider = ChangeNotifierProvider((ref)=> CategoriesRepo(ref.watch(dataServiceProvider)));
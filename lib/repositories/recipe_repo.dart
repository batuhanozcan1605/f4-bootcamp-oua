import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class RecipeRepo extends ChangeNotifier {
  List<String> ingredients = [];
  List<String> recipeTitles = [];


  final apiKey = '0444ff2bef2f4a949766be8b9b6343bc'; // Spoonacular API anahtarı

  Future<void> fetchRecipes() async {
    print("fetch recipe");
    await fetchNames();
    List<String> combinedIngredients = [];

    // Malzemeleri sırayla birbiriyle kombinasyon yaparak yeni bir liste oluştur
    for (int i = 0; i < ingredients.length; i++) {
      for (int j = i + 1; j < ingredients.length; j++) {
        combinedIngredients.add('${ingredients[i]},${ingredients[j]}');
      }
    }
    print("combined: $combinedIngredients");
    var responseCount = combinedIngredients.length < 4 ? combinedIngredients.length : 4;


    // Kombine edilmiş malzemelerle sorguları yap ve tarifleri al
    for (int i = 0; i < responseCount; i++) {
      final url = Uri.parse(
          'https://api.spoonacular.com/recipes/findByIngredients?apiKey=$apiKey&ingredients=${combinedIngredients[i]}&number=10');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        recipeTitles =
        data.map<String>((recipe) => recipe['title'] as String).toList();

      } else {
        throw ('Tarifler alınırken bir hata oluştu');
      }
    }
    notifyListeners();
  }

  Future<void> fetchNames() async {
    print("fetch name");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    List<String> foodNameList = [];
    try{
      FirebaseFirestore.instance.collection('users').doc(uid).collection('kitchen')
          .get()
          .then((QuerySnapshot querySnapshot) async {
        for (DocumentSnapshot doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>; // Explicitly cast to Map
          if (data.containsKey('name')) {
            final foodName = data['name'] as String;
            print("object food name $foodName");
            foodNameList.add(foodName);
          }
        }
        ingredients = foodNameList;
        notifyListeners();
      });
    } catch(e) {

    }

    print("food name list $foodNameList");


  }

  void resetData() {
    ingredients = [];
    recipeTitles = [];
    notifyListeners();
  }

}

final recipeProvider = ChangeNotifierProvider((ref) => RecipeRepo());
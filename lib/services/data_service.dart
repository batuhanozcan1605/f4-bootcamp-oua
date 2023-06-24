import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/CategoryModel.dart';
import '../models/FoodModel.dart';

class DataService {

  Future<List<Category>> getCategories() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').orderBy("categoryId").get();

    List<Category> dataList = [];
    snapshot.docs.forEach((doc) {
      Category category = Category.fromSnapshot(doc);
      dataList.add(category);
    });

    return dataList;
  }

  Future<List<Food>> getFood(categoryId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('foods').where('categoryId', isEqualTo: categoryId).get();

    List<Food> dataList = [];
    snapshot.docs.forEach((doc) {
      Food food = Food.fromSnapshot(doc);
      dataList.add(food);
    });

    return dataList;
  }

  Future<String> getImageUrl(category_image) async {
    try {
      final storageRef =
      FirebaseStorage.instance.ref().child("categories/${category_image}");
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

  Future<String> getFoodImageUrl(image) async {
    try {
      print("debug : $image");
      final storageRef =
      FirebaseStorage.instance.ref().child("foods/$image");
      final downloadUrl = await storageRef.getDownloadURL();
      print("debug : $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

}
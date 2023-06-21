import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../models/CategoryModel.dart';

class DataService {

  Future<List<Category>> getCategories() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').get();

    List<Category> dataList = [];
    snapshot.docs.forEach((doc) {
      Category category = Category.fromSnapshot(doc);
      dataList.add(category);
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
      return ''; // or you can return a default URL or handle the error as desired
    }
  }




  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<List<String>> getImageUrls(String path) async {
    List<String> imageUrls = [];
    ListResult result = await storage.ref().child(path).listAll();

    for (Reference ref in result.items) {
      String url = await ref.getDownloadURL();
      imageUrls.add(url);
    }

    return imageUrls;
  }
}
import 'package:bootcamp_oua_f4/firebasetest/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataService {

  Future<List<Category>> getCategories() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('categories').get();

    return querySnapshot.docs.map((e) => Category.fromMap(e.data())).toList();

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
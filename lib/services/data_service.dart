import 'package:bootcamp_oua_f4/firebasetest/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {

  Future<List<Category>> getCategories() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('categories').get();

    return querySnapshot.docs.map((e) => Category.fromMap(e.data())).toList();
  }
}
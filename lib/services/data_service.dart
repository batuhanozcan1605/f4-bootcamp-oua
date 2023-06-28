import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/CategoryModel.dart';
import '../models/FoodModel.dart';

class DataService {

  Future<List<Category>> getCategories() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(
        'categories').orderBy("categoryId").get();

    List<Category> dataList = [];
    snapshot.docs.forEach((doc) {
      Category category = Category.fromSnapshot(doc);
      dataList.add(category);
    });

    return dataList;
  }

  Future<List<Food>> getFoods(categoryId) async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(
        'foods').where('categoryId', isEqualTo: categoryId).get();

    List<Food> dataList = [];
    snapshot.docs.forEach((doc) {
      Food food = Food.fromSnapshot(doc);
      dataList.add(food);
    });

    return dataList;
  }


    Future<String> getImageUrl(categoryImage) async {
    try {
      final storageRef =
      FirebaseStorage.instance.ref().child("categories/${categoryImage}");
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

  Future<String> getFoodImageUrl(image) async {
    try {

      final storageRef =
      FirebaseStorage.instance.ref().child("foods/$image");
      final downloadUrl = await storageRef.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

  /*Future<List<Food>> searchFoods(query) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(
        'foods')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .get();
    List<Food> dataList = [];
    snapshot.docs.forEach((doc) {
      Food food = Food.fromSnapshot(doc);
      dataList.add(food);
    });

    return dataList;
  }*/

  Future<void> addFoodToKitchen(documentId) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      DocumentSnapshot sourceDocument = await FirebaseFirestore.instance
          .collection('foods')
          .doc(documentId)
          .get();

      if (sourceDocument.exists) {
        DocumentReference destinationRef = FirebaseFirestore.instance
            .collection('users').doc(uid).collection('kitchen').doc();


        await destinationRef.set(sourceDocument.data()!);

        print('Document copied');
      } else {
        print('No Source document');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> undoAdd() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users').doc(uid).collection('kitchen')
          .get();

      DocumentSnapshot lastDocument = querySnapshot.docs.last;

      await lastDocument.reference.delete();

    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<Food>> showFoodInKitchen(categoryId, place) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users').doc(uid).collection('kitchen')
          .where('categoryId', isEqualTo: categoryId)
          .where('place', isEqualTo: place)
          .get();

      List<Food> dataList = [];
      snapshot.docs.forEach((doc) {
        Food food = Food.fromSnapshot(doc);
        dataList.add(food);
      });
      return dataList;

}

}

final dataServiceProvider = Provider((ref) => DataService());
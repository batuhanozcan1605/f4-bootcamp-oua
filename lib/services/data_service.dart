import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
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

  Future<void> addSingleFoodToKitchen(documentId) async {
    late bool exists;
    try {
      DocumentSnapshot sourceDocument = await FirebaseFirestore.instance
          .collection('foods')
          .doc(documentId)
          .get();

      if (sourceDocument.exists) {
        DocumentReference destinationRef = FirebaseFirestore.instance
            .collection('users').doc(Constants.uid).collection('kitchen').doc();

        exists = await FoodsRepo().doesNameExists(sourceDocument['name']);
        if (!exists) {
          Map<String, dynamic>? documentData = sourceDocument.data() as Map<String, dynamic>?;
          if (documentData != null) {
            documentData['enterDate'] = FieldValue.serverTimestamp();
          }
          await destinationRef.set(documentData);
        }
        print('Document copied');
      } else {
        print('No Source document');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> undoAdd() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users').doc(Constants.uid).collection('kitchen')
          .get();

      DocumentSnapshot lastDocument = querySnapshot.docs.last;

      await lastDocument.reference.delete();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addFoodFromCart(documentId) async {
    late bool exists;
    try {
      DocumentSnapshot sourceDocument = await Constants.shoppingCartRef
          .doc(documentId)
          .get();

      if (sourceDocument.exists) {
        DocumentReference destinationRef = Constants.kitchenRef.doc();

        exists = await FoodsRepo().doesNameExists(sourceDocument['name']);
        if (!exists) {
          Map<String, dynamic>? documentData = sourceDocument.data() as Map<String, dynamic>?;
          if (documentData != null) {
            documentData['enterDate'] = FieldValue.serverTimestamp();
          }
          await destinationRef.set(documentData);
        }
        print('Document copied');
      } else {
        print('No Source document');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteFoodFromCart(documentId) async {
    try {
      await Constants.shoppingCartRef
          .doc(documentId)
          .delete();
    } catch (e) {
      print(e);
    }
  }


}
final dataServiceProvider = Provider((ref) => DataService());
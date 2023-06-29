import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/data_service.dart';

class FoodsRepo extends ChangeNotifier {

  List<String> selectedDocumentIds = [];

  void toggleFoodSelection(food) {
    String documentId = food.id;
    if (selectedDocumentIds.contains(documentId)) {
      selectedDocumentIds.remove(documentId);
    } else {
      selectedDocumentIds.add(documentId);
    }

    notifyListeners();
  }

  Future<void> addBatchToKitchen() async {
    late bool exists;
    try {
      for(var docId in selectedDocumentIds) {
      DocumentSnapshot sourceDocument = await FirebaseFirestore.instance
          .collection('foods')
          .doc(docId)
          .get();

      if (sourceDocument.exists) {
        DocumentReference destinationRef = FirebaseFirestore.instance
            .collection('users').doc(Constants.uid).collection('kitchen').doc();

        exists = await doesNameExists(sourceDocument['name']);
        if(!exists) {
          print(exists);
          await destinationRef.set(sourceDocument.data()!);
        }


        print('Document copied');
      } else {
        print('No Source document');
      }
      }
      selectedDocumentIds.clear();
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();
  }

  Future<void> addBatchToCart() async {
    late bool exists;
    try {
      for(var docId in selectedDocumentIds) {
        DocumentSnapshot sourceDocument = await FirebaseFirestore.instance
            .collection('foods')
            .doc(docId)
            .get();


        if (sourceDocument.exists) {
          DocumentReference destinationRef = Constants.shoppingCartRef.doc();

          exists = await doesNameExistsInCart(sourceDocument['name']);
          if(!exists) {
            print(exists);
            await destinationRef.set(sourceDocument.data()!);
          }

          print('Document copied');
        } else {
          print('No Source document');
        }
      }
      selectedDocumentIds.clear();
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();
  }



  Future<bool> doesNameExists(String name) async {
    final querySnapshot = await FirebaseFirestore.instance.collection('users').doc(Constants.uid).collection('kitchen').get();

    for (final doc in querySnapshot.docs) {
      final fieldValue = doc.data()['name'] as String?;
      if (fieldValue != null && fieldValue == name) {
        return true;
      }
    }

    return false;
  }

  Future<bool> doesNameExistsInCart(String name) async {
    final querySnapshot = await Constants.shoppingCartRef.get();

    for (final doc in querySnapshot.docs) {
      final fieldValue = doc.data()['name'] as String?;
      if (fieldValue != null && fieldValue == name) {
        return true;
      }
    }

    return false;
  }


}

final foodsProvider = ChangeNotifierProvider((ref) => FoodsRepo());
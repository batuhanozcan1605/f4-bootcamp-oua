import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodsRepo extends ChangeNotifier {

  List<String> selectedDocumentIds = [];
  List<String> selectedKitchenDocumentIds = [];
  bool tapInKitchen = false;

  void toggleFoodSelection(food, inKitchen) {
    String documentId = food.id;
    if (selectedDocumentIds.contains(documentId)) {
      selectedDocumentIds.remove(documentId);
      if(inKitchen) {
        tapInKitchen = false;
        selectedKitchenDocumentIds.remove(documentId);
      }
    } else {
      selectedDocumentIds.add(documentId);
      if(inKitchen) {
        tapInKitchen = true;
        selectedKitchenDocumentIds.add(documentId);
      }
    }

    notifyListeners();
  }

  void cancelTapInKitchen() {
    tapInKitchen = false;
    selectedDocumentIds.clear();
    selectedKitchenDocumentIds.clear();
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
      }
      selectedDocumentIds.clear();
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();
  }

  Future<void> deleteBatchFromKitchen() async {
    try {
      for(var docId in selectedKitchenDocumentIds) {
        Constants.kitchenRef.doc(docId).delete();
      }
      selectedKitchenDocumentIds.clear();
    }catch (e){
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

  Future<void> setEnterDate(docRef) async {
    docRef.set({
      'enterDate' : DateTime.now()
    });
  }

  Future<void> updatePlace(String field, dynamic value) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      for(var docId in selectedKitchenDocumentIds) {
        print("DOC ID: $docId");
        DocumentReference documentReference = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('kitchen')
            .doc(docId);
        await documentReference.update({
          field: value
        });
      }
      //selectedKitchenDocumentIds.clear();
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();
  }

  Future<bool> doesNameExists(String name) async {
    final querySnapshot = await Constants.kitchenRef.get();

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
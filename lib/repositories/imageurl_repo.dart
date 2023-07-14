import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageUrlRepository extends ChangeNotifier {
  Map<String, String> imageUrls = {};
  List<String> customFoodImageNames = [
    "1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png", "10.png", "11.png", "12.png"
  ];

  void updateImageUrl(String path, String url) {
    imageUrls[path] = url;
    notifyListeners();
  }

  Future<void> fetchImageUrls() async {
    try{
      //Fetch custom food category images
      for(var i = 1; i <= 12; i++) {
        print("DEBUG $i");
        String index = i.toString();
        final url = await FirebaseStorage.instance
            .ref()
            .child('foods/$index.png')
            .getDownloadURL();
        updateImageUrl('$index.png', url);
      }

    FirebaseFirestore.instance
        .collection('foods')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (DocumentSnapshot doc in querySnapshot.docs) {
        final path = doc['image'] as String;
        final url = await FirebaseStorage.instance
            .ref()
            .child('foods/$path')
            .getDownloadURL();
        updateImageUrl(path, url);
      }
    });


    // ignore: empty_catches
    }catch(e){

    }
    //notifyListeners();
  }
}

final imageUrlProvider = ChangeNotifierProvider((ref) => ImageUrlRepository());

/*
final imageUrlProvider2 = Provider<ImageUrlRepository>((ref) {
  final repository = ImageUrlRepository();

  FirebaseFirestore.instance
      .collection('foods')
      .get()
      .then((QuerySnapshot querySnapshot) async {
    for (DocumentSnapshot doc in querySnapshot.docs) {
      final path = doc.data()['foods/$image'] as String;
      final url = await FirebaseStorage.instance
          .ref()
          .child('foods/$image')
          .getDownloadURL();
      repository.updateImageUrl(path, url);
    }
  });

  return repository;
});*/

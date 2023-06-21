import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String category_image;
  final String category_name;

  Category({required this.category_image, required this.category_name});

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Category(
      category_image: data['category_image'],
      category_name: data['category_name'] ?? '',
      // Map other properties as required
    );
  }


}
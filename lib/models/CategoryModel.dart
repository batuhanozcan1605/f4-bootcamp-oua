import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final int categoryId;
  final String categoryImage;
  final String categoryName;

  Category({ required this.categoryId, required this.categoryImage, required this.categoryName});

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Category(
      categoryId: data["categoryId"] ?? 1,
      categoryImage: data['categoryImage'] ?? '',
      categoryName: data['categoryName'] ?? '',
    );
  }


}
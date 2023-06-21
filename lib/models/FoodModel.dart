import 'package:cloud_firestore/cloud_firestore.dart';

class Food {

  final String categoryId;
  final String name;
  final String image;
  final String place;
  final DateTime enterDate;
  final int shelfTime;

  Food(
      {required this.categoryId,
      required this.name,
      required this.image,
      required this.place,
      required this.enterDate,
      required  this.shelfTime
      }
      );

  factory Food.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Food(
      categoryId: data['categoryId'] ?? 1,
      name: data['name'] ?? '',
      image: data['image'],
      place: data['place'],
      enterDate: data['enterDate'],
      shelfTime: data['shelfTime'],
    );
  }

}
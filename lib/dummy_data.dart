import 'models/FoodModel.dart';

final List<Foods> foods= [
   Foods(category_id: 1, food_name: "Tomato", food_image: Assets.tomato, place: "b"),
   Foods(category_id: 2, food_name: "Tomato", food_image: Assets.tomato, place: "b"),
];


class Assets {
   static const String _images = 'assets/images/';

   static const String tomato = '${_images}/tomato.png';
}
import 'models/FoodModel.dart';

final List<Food> foods= [
   Food(category_id: "1", name: "Tomato", image: Assets.tomato, place: "b"),
   Food(category_id: "2", name: "Tomato", image: Assets.tomato, place: "b"),
];


class Assets {
   static const String _images = 'assets/images/';

   static const String tomato = '${_images}/tomato.png';
}
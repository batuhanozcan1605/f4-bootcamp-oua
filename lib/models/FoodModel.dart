class Foods {

  final int category_id;
  final String food_name;
  final String? food_image;
  final String place;
  final int? shelfTime;

  Foods(
      {required this.category_id,
      required this.food_name,
      this.food_image,
      required this.place,
      this.shelfTime}
      );
}
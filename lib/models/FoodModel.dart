class Foods {

  final String category_id;
  final String name;
  final String? image;
  final String place;
  final int? shelfTime;

  Foods(
      {required this.category_id,
      required this.name,
      this.image,
      required this.place,
      this.shelfTime}
      );
}
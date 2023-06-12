
class Category {
  String? category_image;
  String? category_name;

  Category(this.category_image, this.category_name);

  Category.fromMap(Map<String, dynamic> m) : this(
    m['category_image'], m['category_name']
  );

  Map<String, dynamic> toMap() {
    return {
      'category_image' : category_image,
      'category_name' : category_name,
    };
  }

}


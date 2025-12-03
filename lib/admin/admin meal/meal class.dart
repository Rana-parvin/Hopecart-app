class Mealclass {
  final String mealid;
  final String size;
  final String name;
  final String price;
  final String description;
  final String image;
  final String ingredients;
  Mealclass( {
   required this.ingredients,
    required this.mealid,
    required this.description,
    required this.size,
    required this.image,
    required this.name,
    required this.price,
  });

  String? operator [](String other) {
    return null;
  }
}

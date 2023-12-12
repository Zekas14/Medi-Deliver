class Product {
  String imagePath;
  String description;
  Category category;
  int price;
  Product({
    required this.imagePath,
    required this.description,
    required this.category,
    required this.price,
  });
}
 enum  Category {
  hairCare,
  skinCare,
  babyCare,
  healthCare,
}

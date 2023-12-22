import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  String imagePath;
  String description;
  String category;
  int price;
  Product({
    required this.name,
    required this.imagePath,
    required this.description,
    required this.category,
    required this.price,
  });
  // Override == operator for equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.imagePath == imagePath &&
        other.description == description &&
        other.category == category &&
        other.price == price;
  }

  // Override hashCode for consistency with == operator
  @override
  int get hashCode {
    return name.hashCode ^
        imagePath.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode;
  }
}

Future<void> addProductsToFirestore(List<Product> products) async {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Product');

  for (Product product in products) {
    await productsCollection.add({
      'image': product.imagePath,
      'description': product.description,
      'name': product.name,
      'category': product.category,
      'price': product.price,
      // Add more fields as needed
    });
  }
}

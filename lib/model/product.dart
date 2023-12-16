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
}

Future<void> addProductsToFirestore(List<Product> products) async {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Product');

  for (Product product in products) {
    await productsCollection.add({
      'image' : product.imagePath,
      'description' : product.description,
      'name': product.name,
      'category': product.category,
      'price': product.price,
      // Add more fields as needed
    });
  }
}

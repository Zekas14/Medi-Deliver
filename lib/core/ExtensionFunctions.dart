import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/model/product.dart';

extension SnackBarExtension on BuildContext {
  void showCustomSnackBar({
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  void showCustomDialog(List<Widget> list) {
    showDialog(
      context: this,
      barrierDismissible: false, // prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: list,
          ),
        );
      },
    );
  }
}
Stream<List<Product>> fetchProductsStream() {
  return FirebaseFirestore.instance.collection('Product').snapshots().map(
    (querySnapshot) {
      List<Product> products = [];
      for (QueryDocumentSnapshot productDoc in querySnapshot.docs) {
        Map<String, dynamic> productData =
            productDoc.data() as Map<String, dynamic>;
        Product product = Product(
          category: productDoc['category'] ?? '',
          description: productData['description'] ?? '',
          imagePath: productData['image'] ?? '',
          name: productData['name'] ?? '',
          price: productData['price'] ?? 50,
          // Add more fields based on your product model
        );

        products.add(product);
      }
      return products;
    },
  );
}
// Example usage

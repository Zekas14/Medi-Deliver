import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';
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

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addToCart(String name, String description, int price, String image) async {
  try {
    // Check if an item with the same description, price, and image already exists
    QuerySnapshot duplicateItems = await _firestore
        .collection('cart')
        .where('description', isEqualTo: description)
        .where('price', isEqualTo: price)
        .where('image', isEqualTo: image)
        .get();

    if (duplicateItems.docs.isEmpty) {
      // If no duplicate items found, add the new item to the cart
      await _firestore.collection('cart').add({
        'name' : name,
        'description': description,
        'price': price,
        'image': image,
      });
    } else {
      print('No');
    }
  } catch (e) {
    print('Error adding to cart: $e');
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
            category: productDoc['category']??'',
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

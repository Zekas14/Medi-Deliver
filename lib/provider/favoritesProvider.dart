import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/model/product.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Product> products = [];

  Future<List<Product>> refreshProductsList() async {
    print("Refreshing Products List");

    CollectionReference<Product> productsCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favourite')
        .withConverter<Product>(
      fromFirestore: (docSnapshot, _) {
        Map<String, dynamic> json = docSnapshot.data() as Map<String, dynamic>;
        return Product.fromJson(json);
      },
      toFirestore: (product, _) {
        return product.toJson();
      },
    );

    QuerySnapshot<Product> productsSnapshot =
        await productsCollection.orderBy("name").get();

    List<QueryDocumentSnapshot<Product>> docs = productsSnapshot.docs;

    products = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();
    print("Products Count: ${products.length}");
    notifyListeners();
    return products;
  }

  void deleteFavourite(String id) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favourite')
        .doc(id)
        .delete()
        .timeout(const Duration(milliseconds: 300), onTimeout: () {
      refreshProductsList();

      // provider.getProductByCode();
    });
    notifyListeners();
  }
}

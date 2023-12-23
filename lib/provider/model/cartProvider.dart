import 'package:flutter/material.dart';
import 'package:medi_deliver/component/cartContianer.dart';
import 'package:medi_deliver/model/cartItemModel.dart';

import '../../model/product.dart';

class Cart extends ChangeNotifier {
  List<CartItem> cartItemsList = [];
  List<CartContainer> cartContianers = [];

  void addToCart(Product product) {
    CartItem tempItem;
    print("start");
    for (var element in cartItemsList) {
      if (element.product == product) {
        element.incrementQuantity();
        notifyListeners();
        return;
      }
    }
    tempItem = CartItem(product: product, quantity: 1);
    cartItemsList.add(tempItem);
    cartContianers.add(CartContainer(cartItem: tempItem));
    print("end ${tempItem.product.name}");
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    if (cartItemsList.isNotEmpty) {
      cartItemsList.remove(cartItemsList
          .firstWhere((element) => element.product == cartItem.product));
      cartContianers.remove(
        cartContianers.firstWhere(
            (element) => element.cartItem.product == cartItem.product),
      );

      notifyListeners();
    }
  }
}

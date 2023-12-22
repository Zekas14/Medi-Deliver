import 'package:medi_deliver/model/product.dart';

class CartItem {
  Product product;
  int quantity = 1;
  CartItem({required this.product, required this.quantity});
  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    quantity--;
  }
}

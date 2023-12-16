import 'package:medi_deliver/model/product.dart';

class OrderContent {
  Product product;
  int quantity = 1;
  OrderContent({required this.product, required this.quantity});
}


import 'package:medi_deliver/model/cartItemModel.dart';
class Order {
  final int orderId;
   final DateTime date;
  final String buyerName;
  final String buyerLocation;
   List<CartItem> Items;
  final double discount;
  final double tax;

  Order({
    required this.orderId,
    required this.date,
    required this.buyerName,
    required this.buyerLocation,
    required this.Items,
    required this.discount,
    this.tax = 13,
  });

  double calculateTotalAmount() {
    double total = 0.0;
    for (var item in Items) {
      total += item.product.price * item.quantity;
    }
    total -= discount;
    
    // Calculate tax as 10% of the order total
    total += total * (tax / 100);
    
    return total;
  }
}





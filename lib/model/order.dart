import 'package:medi_deliver/model/cartItemModel.dart';

class Order {
  final int orderId;
  final DateTime date;
  String orderStatus = 'Pending';
  final String? buyerName;
  final String? buyerId;
  final String? buyerLocation;
  List<CartItem> Items;
  final double discount;
  final double tax;
  double totalAmount = 0;

  Order({
    required this.orderId,
    required this.buyerId,
    required this.date,
    required this.buyerName,
    required this.buyerLocation,
    required this.Items,
    required this.discount,
    this.tax = 13,
  });

  double calculateTotalAmount() {
    for (var item in Items) {
      totalAmount += item.product.price * item.quantity;
    }
    totalAmount -= discount;

    // Calculate tax as 10% of the order total
    totalAmount += totalAmount * (tax / 100);

    return totalAmount;
  }
}

import 'dart:math';

import 'package:medi_deliver/component/MedicineItem.dart';
class Order {
  final int orderId;
   final DateTime date;
  final String buyerName;
  final String buyerLocation;
   List<MedicineItem> medicineItems;
  final double discount;
  final double tax;

  Order({
    required this.orderId,
    required this.date,
    required this.buyerName,
    required this.buyerLocation,
    required this.medicineItems,
    required this.discount,
    this.tax = 13,
  });

  double calculateTotalAmount() {
    double total = 0.0;
    for (var item in medicineItems) {
      total += item.price * item.quantity;
    }
    total -= discount;
    
    // Calculate tax as 10% of the order total
    total += total * (tax / 100);
    
    return total;
  }
}





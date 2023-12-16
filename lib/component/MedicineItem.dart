
import 'package:flutter/material.dart';

class MedicineItem extends StatelessWidget {
  final String name;
  final int quantity;
  final double price;

  const MedicineItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$name x $quantity'),
          Text('\$${(price * quantity).toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}

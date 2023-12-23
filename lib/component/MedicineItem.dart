import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';

class MedicineItem extends StatelessWidget {
  final String name;
  final int quantity;
  final int price;

  const MedicineItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 232, 231, 231)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$quantity x $name ',
            style: const TextStyle(
              fontFamily: fontFamilyString,
              fontSize: 15,
              color: fontSecondaryColor,
            ),
          ),
          Text(
            '\$${(price * quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: fontFamilyString,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

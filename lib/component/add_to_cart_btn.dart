import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("mango2");
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(164, 45),
        primary: const Color(0xFF34D49E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: const Text(
        'Add To Cart',
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

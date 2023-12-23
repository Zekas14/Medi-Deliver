import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/product.dart';
import 'package:provider/provider.dart';

import '../provider/model/cartProvider.dart';

// ignore: must_be_immutable
class AddToCartBtn extends StatelessWidget {
  Product product;
  AddToCartBtn({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<Cart>(context, listen: false).addToCart(product);
        context.showCustomSnackBar(
            message: 'Added to cart', color: Colors.green);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(164, 45),
        primary: buttonColor,
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

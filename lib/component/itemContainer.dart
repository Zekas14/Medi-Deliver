import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/dummy_product_list.dart';
import 'package:medi_deliver/provider/model/cartProvider.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
// import 'package:medi_deliver/model/product.dart';

// ignore: must_be_immutable
class ItemContainer extends StatelessWidget {
  Product product;
  ItemContainer({
    super.key,
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 20,
        right: 30,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: outlineBorderColor,
          )),
      child: Column(
        children: [
          Row(
            children: [
              productImage(),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  product.description,
                  style: const TextStyle(
                    fontFamily: fontFamilyString,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: outlineBorderColor,
          ),
          Row(
            children: [
              priceText(context, product.price.toDouble()),
              const Spacer(
                flex: 1,
              ),
              Center(
                child: customButton(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget productImage() {
    return Image.asset(
      product.imagePath,
      height: 100,
      width: 100,
    );
  }

  Widget customButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Cart>(context, listen: false).addToCart(product);
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 22,
          right: 22,
          top: 12,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: const Center(
          child: Text(
            'Add to Cart',
            style: TextStyle(
              fontSize: 14,
              color: backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget priceText(BuildContext context, double price) {
    return RichText(
        text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
      const TextSpan(
        text: 'Unit Price: ',
        style: TextStyle(
          color: fontSecondaryColor,
          fontSize: 18,
          fontFamily: fontFamilyString,
        ),
      ),
      TextSpan(
        text: price.toString(),
        style: const TextStyle(
          color: Color.fromARGB(255, 227, 76, 85),
          fontSize: 18,
          fontFamily: fontFamilyString,
        ),
      ),
    ]));
  }
}

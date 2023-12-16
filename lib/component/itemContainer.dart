import 'package:flutter/material.dart';
import 'package:medi_deliver/component/add_to_cart_btn.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/product.dart';

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
              priceText(context, product.price),
              const Spacer(
                flex: 1,
              ),
              Center(
                child: AddToCartBtn(product: product),
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

  Widget priceText(BuildContext context, int price) {
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

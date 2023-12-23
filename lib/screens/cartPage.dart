import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/dummy_product_list.dart';
import 'package:medi_deliver/model/cartItemModel.dart';
import 'package:medi_deliver/provider/model/cartProvider.dart';
import 'package:medi_deliver/screens/invoice.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartPage extends StatefulWidget {
  List<CartItem>? cartItem = [];

  CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<Cart>(
              builder: (context, cart, child) {
                return ListView.builder(
                  itemCount: Provider.of<Cart>(context, listen: false)
                      .cartContianers
                      .length,
                  itemBuilder: (context, index) {
                    if (!widget.cartItem!.contains(
                        Provider.of<Cart>(context, listen: false)
                            .cartContianers[index]
                            .cartItem)) {
                      widget.cartItem!.add(
                          Provider.of<Cart>(context, listen: false)
                              .cartContianers[index]
                              .cartItem);
                    }
                    return Provider.of<Cart>(context, listen: false)
                        .cartContianers[index];
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: "Check out",
              onTap: () async {
                if (widget.cartItem!.isNotEmpty) {
                  cartItem.addAll(widget.cartItem!);
                  // addToOrderContent();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Invoice(),
                    ),
                  );
                } else {
                  context.showCustomSnackBar(
                    message: 'cart is empty',
                    color: errorColor,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addToOrderContent() async {
    try {
      for (var element in widget.cartItem!) {
        await FirebaseFirestore.instance.collection('order_content').add({
          'name': element.product.name,
          'price': element.product.price * element.quantity,
          'quantity': element.quantity,
          // Add more fields based on your data model
        });
      }
      print('Added');
    } catch (error) {
      print(error);
    }
  }
}

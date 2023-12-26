import 'package:flutter/material.dart';
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
                if (Provider.of<Cart>(context, listen: false)
                    .cartItemsList
                    .isNotEmpty) {
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
}

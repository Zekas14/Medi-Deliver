import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medi_deliver/component/cartContianer.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/model/cartItemModel.dart';
import 'package:medi_deliver/model/product.dart';
import 'package:medi_deliver/provider/model/cartProvider.dart';
import 'package:medi_deliver/screens/invoice.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartPage extends StatefulWidget {
  CartItem? cartItem;

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
            child: StreamBuilder<QuerySnapshot>(
              // Replace 'cart' with your actual collection name
              stream: FirebaseFirestore.instance.collection('cart').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final documents = snapshot.data!.docs;

                  return Consumer<Cart>(
                    builder: (context, cart, child) {
                      return ListView.builder(
                        itemCount: Provider.of<Cart>(context, listen: false)
                            .cartContianers
                            .length,
                        itemBuilder: (context, index) {
                          // final document = documents[index];
                          // final product = Product(
                          //   name: document['name'],
                          //   imagePath: document['image'],
                          //   // Assuming you have a Product class or similar
                          //   description: document['description'],
                          //   price: document['price'] ?? 0.0,
                          //   category: 'Baby Care',
                          //   // Add more fields based on your data model
                          // );
                          // widget.cartItem =
                          //     CartItem(product: product, quantity: 1);
                          // totalPrice += product.price;

                          return Provider.of<Cart>(context, listen: false)
                              .cartContianers[index];
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: "Check out",
              onTap: () async {
                addToOrderContent();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Invoice(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addToOrderContent() async {
    try {
      await FirebaseFirestore.instance.collection('order_content').add({
        'quantity': widget.cartItem!.quantity,
        'product': {
          'description': widget.cartItem!.product.description,
          'price': widget.cartItem!.product.price * widget.cartItem!.quantity,
        },
        // Add more fields based on your data model
      });
      print('Added');
    } catch (error) {
      print(error);
    }
  }
}

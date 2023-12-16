import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medi_deliver/component/cartContianer.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/dummy_product_list.dart'; // Import your model or data class
import 'package:medi_deliver/model/orderContent.dart';
import 'package:medi_deliver/model/product.dart';
import 'package:medi_deliver/screens/InvoiceScreen.dart';
import 'package:medi_deliver/screens/invoice.dart';

class CartPage extends StatefulWidget {
  OrderContent? orderContent;
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

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      final product = Product(
                        name: document['name'],
                        imagePath: document['image'],
                        // Assuming you have a Product class or similar
                        description: document['description'],
                        price: document['price'] ?? 0.0,
                        category:'Baby Care' ,
                        // Add more fields based on your data model
                      );
                      widget.orderContent =
                          OrderContent(product: product, quantity: 1);
                      totalPrice += product.price;

                      return CartContainer(
                        orderContent: widget.orderContent!,
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
        'quantity': widget.orderContent!.quantity,
        'product': {
          'description': widget.orderContent!.product.description,
          'price': widget.orderContent!.product.price *
              widget.orderContent!.quantity,
        },
        // Add more fields based on your data model
      });
      print('Added');
    } catch (error) {
      print(error);
    }
  }
}

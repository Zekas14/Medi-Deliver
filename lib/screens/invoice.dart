import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/component/MedicineItem.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/dummy_product_list.dart';
import 'package:medi_deliver/model/order.dart' as model;

class Invoice extends StatelessWidget {
  final model.Order order = model.Order(
    orderId: Random().nextInt(1000000), // Generate a random order ID
    date: DateTime.now(),
    buyerName: 'John Doe',
    buyerLocation: '123 Main St, Cityville',
    Items: cartItem,
    discount: 5.00,
    // Set tax as a fixed 10%
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          left: 20,
          right: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamilyString,
              ),
            ),
            const SizedBox(height: 10),
            myText('Order ID: #${order.orderId}'),
            myText('Date: ${order.date}'),
            myText('Buyer: ${order.buyerName}'),
            myText('Location: ${order.buyerLocation}'),
            const SizedBox(height: 20),
            const Text(
              'Medicine Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamilyString,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: cartItem.length,
                  itemBuilder: ((context, index) {
                    return MedicineItem(
                      name: cartItem[index].product.name,
                      quantity: cartItem[index].quantity,
                      price: cartItem[index].product.price,
                    );
                  })),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discount: \$${order.discount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green, // Green color for discount
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamilyString,
                  ),
                ),
                Text(
                  'Tax: %${order.tax.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red, // Red color for tax
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamilyString,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Total Amount: \$${order.calculateTotalAmount().toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamilyString,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: CustomButton(text: 'Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }

  Text myText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: fontSecondaryColor,
        fontFamily: fontFamilyString,
        fontSize: 16,
      ),
    );
  }

  Future<void> addOrderToFirestore(model.Order order) async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'orderId': order.orderId,
        'date': order.date,
        'buyerName': order.buyerName,
        'buyerLocation': order.buyerLocation,
        'discount': order.discount,
        'tax': order.tax,
        'totalAmount': order.calculateTotalAmount(),
        'items': order.Items.map((item) {
          return {
            'name': item.product.name,
            'quantity': item.quantity,
            'price': item.product.price,
          };
        }).toList(),
      });

      print('Order added to Firestore');
    } catch (error) {
      print('Error adding order to Firestore: $error');
    }
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medi_deliver/component/MedicineItem.dart';
import 'package:medi_deliver/model/order.dart';

class Invoice extends StatelessWidget {
  final Order order = Order(
  orderId: Random().nextInt(1000000), // Generate a random order ID
  date: DateTime.now(),
  buyerName: 'John Doe',
  buyerLocation: '123 Main St, Cityville',
  medicineItems: [
    MedicineItem(name: 'panadol ', quantity: 2, price: 15.99),
    MedicineItem(name: 'palmers', quantity: 1, price: 24.99),
  ],
  discount: 5.00,
   // Set tax as a fixed 10%
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Delivery Invoice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Order ID: #${order.orderId}'),
            Text('Date: ${order.date}'),
            SizedBox(height: 10),
            Text('Buyer: ${order.buyerName}'),
            Text('Location: ${order.buyerLocation}'),
            SizedBox(height: 20),
            Text(
              'Medicine Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            for (var item in order.medicineItems)
              MedicineItem(name: item.name, quantity: item.quantity, price: item.price),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discount: \$${order.discount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green, // Green color for discount
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tax: \%${order.tax.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red, // Red color for tax
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Total Amount: \$${order.calculateTotalAmount().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for invoice payment, etc.
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff33D49E), // Green color
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(                  
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

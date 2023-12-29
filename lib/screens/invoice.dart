import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medi_deliver/component/MedicineItem.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/core/orderServices.dart';
import 'package:medi_deliver/model/cartItemModel.dart';
import 'package:medi_deliver/model/order.dart' as model;
import 'package:medi_deliver/model/user.dart' as model;
import 'package:medi_deliver/provider/model/cartProvider.dart';
import 'package:medi_deliver/provider/userProvider.dart';
import 'package:provider/provider.dart';

class Invoice extends StatefulWidget {
  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    model.User? loggedInUser = Provider.of<UserProvider>(context).loggedInUser;
    List<CartItem> cartItem =
        Provider.of<Cart>(context, listen: false).cartItemsList;
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    model.Order order = model.Order(
      buyerId: loggedInUser!.uid,
      orderId: Random().nextInt(1000000), // Generate a random order ID
      date: DateTime.now(),
      buyerName: loggedInUser.fullName,
      buyerLocation: loggedInUser.address ?? 'Assuit',
      Items: cartItem,
      discount: 5.00,
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 20,
          right: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamilyString,
              ),
            ),
            const SizedBox(height: 10),
            myText('Order ID: #${order.orderId}'),
            myText('Date: $formattedDate'),
            myText('Buyer: ${order.buyerName}'),
            myText('Location: ${order.buyerLocation}'),
            const SizedBox(height: 20),
            const Text(
              'Medicine Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamilyString,
              ),
            ),
            SizedBox(
              height: 10,
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
              child: CustomButton(
                  text: 'Confirm Order',
                  onTap: () async {
                    OrderService.addOrderToFirestore(order);

                    Provider.of<Cart>(context, listen: false).clearCart();
                    cartItem.clear();
                    context.showCustomSnackBar(
                      message: 'Order Confirmed',
                      color: Colors.green,
                    );
                    Navigator.pop(context);
                  }),
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
}

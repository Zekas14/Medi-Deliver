import 'package:flutter/material.dart';
import 'package:medi_deliver/component/orderCard.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/user.dart';
import 'package:medi_deliver/provider/orderProvider.dart';
import 'package:medi_deliver/provider/userProvider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Color backgroundColor = const Color.fromARGB(255, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    User? loggedInUser = Provider.of<UserProvider>(context).loggedInUser;
    Provider.of<OrderProvider>(context, listen: false)
        .fetchOrders(loggedInUser!.uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Center(
          child: Text(
            'Order',
            style: TextStyle(
              fontFamily: fontFamilyString,
            ),
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Provider.of<OrderProvider>(context).orders!.isEmpty
          ? const Center(child: Text('No orders available.'))
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: Provider.of<OrderProvider>(context).orders!.length,
              itemBuilder: (context, index) {
                return OrderCard(
                  order: Provider.of<OrderProvider>(context).orders![index],
                );
              },
            ),
    );
  }
}

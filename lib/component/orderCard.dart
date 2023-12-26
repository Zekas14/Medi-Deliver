import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/order.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(widget.order.date);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(91, 216, 216, 216),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        // Use SingleChildScrollView here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                fontFamily: fontFamilyString,
                fontSize: 14,
                color: fontSecondaryColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Order ID : #${widget.order.orderId}',
                  style: const TextStyle(
                    fontFamily: fontFamilyString,
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.order.orderStatus,
                  style: const TextStyle(
                    fontFamily: fontFamilyString,
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color.fromARGB(255, 204, 201, 201),
              height: 30,
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap:
                      true, // Ensure it doesn't try to take infinite height
                  itemCount: widget.order.Items.length,
                  itemBuilder: (context, index) {
                    return itemInfo(
                      widget.order.Items[index].quantity,
                      widget.order.Items[index].product.name,
                      widget.order.Items[index].product.price,
                    );
                  },
                ),
                const Divider(
                  color: Color.fromARGB(255, 225, 224, 224),
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontFamily: fontFamilyString,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '\$${widget.order.totalAmount}',
                      style: const TextStyle(
                        fontFamily: fontFamilyString,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemInfo(int quantity, String name, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${quantity}x $name',
          style: const TextStyle(
            color: fontSecondaryColor,
            fontFamily: fontFamilyString,
          ),
        ),
        Text(
          '\$${price * quantity}',
          style: const TextStyle(
            color: fontSecondaryColor,
            fontFamily: fontFamilyString,
          ),
        ),
      ],
    );
  }
}

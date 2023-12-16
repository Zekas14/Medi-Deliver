import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/dummy_product_list.dart';
import 'package:medi_deliver/model/orderContent.dart';
import 'package:medi_deliver/model/product.dart';

class CartContainer extends StatefulWidget {
  OrderContent orderContent;
  int TotalPriceOfMid = 0;
  CartContainer({required this.orderContent});

  @override
  State<CartContainer> createState() => _ItemContianerState();
}

class _ItemContianerState extends State<CartContainer> {
  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    widget.TotalPriceOfMid =
        (widget.orderContent.quantity! * widget.orderContent.product!.price);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: outlineBorderColor,
          )),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
        bottom: 10,
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ProductImage(isSmallScreen),
              SizedBox(width: isSmallScreen ? 10 : 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderContent.product.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 14 : 18,
                        fontFamily: 'DIN Next LT W23',
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          " Unit Price : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff8d8d8d),
                            fontSize: isSmallScreen ? 14 : 18,
                            fontFamily: 'DIN Next LT W23',
                          ),
                        ),
                        Text(
                          '${widget.orderContent.product.price} EGP',
                          style: TextStyle(
                            color: Color(0xffE34C55),
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 14 : 18,
                            fontFamily: 'DIN Next LT W23',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          SizedBox(
            height: isSmallScreen ? 5 : 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.orderContent.quantity > 1) {
                      widget.orderContent.quantity--;
                    } else {}
                  });
                },
                child: Container(
                  child: widget.orderContent.quantity == 1
                      ? Image.asset('asset/images/brush.png')
                      : Image.asset('asset/images/minus.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding:
                    EdgeInsets.only(left: 10, bottom: 6, right: 10, top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: const Color.fromARGB(255, 218, 217, 217)),
                ),
                child: Center(
                  child: Text(
                    '${widget.orderContent.quantity}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 14 : 20,
                      fontFamily: fontFamilyString,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.orderContent.quantity++;
                  });
                },
                child: Container(
                  child: Image.asset('asset/images/plus.png'),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 1),
                child: Text(
                  'Total: ${widget.TotalPriceOfMid}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 14 : 20,
                    fontFamily: 'DIN Next LT W23',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Image ProductImage(bool isSmallScreen) {
    return Image.asset(
      widget.orderContent.product.imagePath,
      width: isSmallScreen ? 50 : 75,
      height: isSmallScreen ? 100 : 75,
    );
  }
}

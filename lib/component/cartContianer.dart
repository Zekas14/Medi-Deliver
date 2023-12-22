import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/cartItemModel.dart';
import 'package:medi_deliver/provider/model/cartProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartContainer extends StatefulWidget {
  CartItem cartItem;
  int totalPriceOfMid = 0;
  CartContainer({super.key, required this.cartItem});

  @override
  State<CartContainer> createState() => _ItemContianerState();
}

class _ItemContianerState extends State<CartContainer> {
  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    widget.totalPriceOfMid =
        (widget.cartItem.quantity * widget.cartItem.product.price);
    return Consumer<Cart>(
      builder: (context, value, child) {
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
                          widget.cartItem.product.description,
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
                              '${widget.cartItem.product.price} EGP',
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
              const Divider(),
              SizedBox(
                height: isSmallScreen ? 5 : 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.cartItem.quantity > 1) {
                          widget.cartItem.decrementQuantity();
                          Provider.of<Cart>(context, listen: false)
                              .notifyListeners();
                        } else {
                          Provider.of<Cart>(context, listen: false)
                              .removeFromCart(widget.cartItem);
                        }
                      });
                    },
                    child: Container(
                      child: widget.cartItem.quantity == 1
                          ? Image.asset('asset/images/brush.png')
                          : Image.asset('asset/images/minus.png'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(
                        left: 10, bottom: 6, right: 10, top: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: const Color.fromARGB(255, 218, 217, 217)),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.cartItem.quantity}',
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
                        widget.cartItem.quantity++;
                      });
                    },
                    child: Image.asset('asset/images/plus.png'),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Text(
                      'Total: ${widget.cartItem.quantity * widget.cartItem.product.price}',
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
      },
    );
  }

  Image ProductImage(bool isSmallScreen) {
    return Image.asset(
      widget.cartItem.product.imagePath,
      width: isSmallScreen ? 50 : 75,
      height: isSmallScreen ? 100 : 75,
    );
  }
}

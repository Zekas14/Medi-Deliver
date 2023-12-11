import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_to_cart_btn.dart';

class ProductWidget extends StatefulWidget {
  String description;
  String? imagePath;
  double price;

  ProductWidget({
    Key? key,
    required this.description,
    this.imagePath,
    required this.price,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isFavorited = false;
  IconData bata = Icons.favorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      constraints: const BoxConstraints(maxWidth: 180, maxHeight: 282),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                constraints:
                    const BoxConstraints(maxWidth: 118, maxHeight: 114),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Image.asset(
                    widget.imagePath ?? "asset/images/default_img.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      widget.description,
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "${widget.price.toStringAsFixed(2)}",
                      style: TextStyle(color: Color(0xFFE34C55)),
                    ),
                  ),
                ],
              ),
              AddToCartBtn(),
            ],
          ),
          Positioned(
            top: 0,
            left: 135,
            right: 0,
            child: InkWell(
              child: Icon(
                _isFavorited ? Icons.favorite : Icons.favorite_border,
                color: _isFavorited ? Colors.red : Colors.grey,
                size: 30.0,
              ),
              onTap: () {
                setState(() {
                  _isFavorited = !_isFavorited;
                  print("mango");
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

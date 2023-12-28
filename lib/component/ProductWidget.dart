import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/product.dart';
import 'package:medi_deliver/provider/favoritesProvider.dart';
import 'package:medi_deliver/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'add_to_cart_btn.dart';

// ignore: must_be_immutable
class ProductWidget extends StatefulWidget {
  Product product;
  bool isFav;
  ProductWidget({
    Key? key,
    required this.product,
    this.isFav = false,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  IconData bata = Icons.favorite;
  late FavoritesProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      constraints: const BoxConstraints(maxWidth: 174, maxHeight: 282),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                constraints: const BoxConstraints(
                    maxWidth: 118, maxHeight: 114, minHeight: 114),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Image.asset(
                    widget.product.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      widget.product.description,
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        fontFamily: fontFamilyString,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "${widget.product.price.toStringAsFixed(2)} EGP",
                      style: const TextStyle(
                          color: Color(0xFFE34C55),
                          fontFamily: fontFamilyString,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              AddToCartBtn(
                product: widget.product,
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 140,
            right: 0,
            child: InkWell(
              child: Icon(
                widget.isFav ? Icons.favorite : Icons.favorite_border,
                color: widget.isFav ? Colors.red : Colors.grey,
                size: 25.0,
              ),
              onTap: () {
                if (!widget.isFav) {
                  addToFavourite();
                } else {
                  Provider.of<FavoritesProvider>(context, listen: false)
                      .deleteFavourite(widget.product.id!);
                }

                setState(() {
                  widget.isFav = !widget.isFav;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void addToFavourite() {
    CollectionReference favCollectionRef = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favourite');
    DocumentReference newEmptyDoc = favCollectionRef.doc();
    newEmptyDoc.set({
      'id': newEmptyDoc.id,
      'image': widget.product.imagePath,
      'description': widget.product.description,
      'name': widget.product.name,
      'category': widget.product.category,
      'price': widget.product.price,
    }).timeout(const Duration(milliseconds: 300), onTimeout: () {
      provider.refreshProductsList();
      // provider.getProductByCode();
    });
  }
}

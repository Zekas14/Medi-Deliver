import 'package:flutter/material.dart';
import 'package:medi_deliver/component/ProductWidget.dart';
import 'package:medi_deliver/component/add_to_cart_btn.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/product.dart';

class ItemsPage extends StatefulWidget {
  final String categoryName;
  final List<Product> products;

  ItemsPage({required this.products, required this.categoryName});

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  // Check if the current index is within the valid range
                  if (index < widget.products.length) {
                    // Build a row with two ProductWidget if the next index is also valid
                    if (index + 1 < widget.products.length) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            ProductWidget(product: widget.products[index]),
                            SizedBox(
                              width: 6,
                            ),
                            ProductWidget(product: widget.products[index + 1]),
                          ],
                        ),
                      );
                    }
                  } else {
                    // Return an empty container if the index is out of range
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _truncateDescription(String description) {
    const int maxDescriptionLength = 50; // Adjust as needed
    return description.length > maxDescriptionLength
        ? '${description.substring(0, maxDescriptionLength)}...'
        : description;
  }
}

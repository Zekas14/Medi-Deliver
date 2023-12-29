import 'package:flutter/material.dart';
import 'package:medi_deliver/component/ProductWidget.dart';
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
          style: TextStyle(
            color: Colors.black,
            fontFamily: fontFamilyString,
          ),
        ),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  // Check if the current index is within the valid range
                  if (index < widget.products.length) {
                    // Build a ProductWidget if the index is valid
                    return Container(
                        child: ProductWidget(product: widget.products[index]));
                  }
                  return Container(); // Placeholder for invalid index
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

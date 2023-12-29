import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medi_deliver/component/ProductWidget.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/provider/favoritesProvider.dart';
import 'package:provider/provider.dart';

class FavItems extends StatefulWidget {
  FavItems() : super();

  @override
  _FavItemsState createState() => _FavItemsState();
}

class _FavItemsState extends State<FavItems> {
  late FavoritesProvider provider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refreshProductsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: TextStyle(color: Colors.black, fontFamily: fontFamilyString),
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
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: provider.products.length,
                itemBuilder: (context, index) => ProductWidget(
                    product: provider.products[index], isFav: true),
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

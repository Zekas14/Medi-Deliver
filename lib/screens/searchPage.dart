import 'package:flutter/material.dart';
import 'package:medi_deliver/component/itemContainer.dart';
import 'package:medi_deliver/component/searchfield.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/dummy_product_list.dart';
import 'package:medi_deliver/model/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController productnameController = TextEditingController();
  List<Product> filteredProductList = [];

  @override
  void initState() {
    super.initState();
    // Initialize the filtered list with the entire product list
    filteredProductList = List.from(productList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 15,
          ),
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.black,
                size: 26,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        child: Column(
          children: [
            CustomTextFormField(
              textStyle:const TextStyle(
                fontFamily: fontFamilyString,
                fontSize: 15,
              ),
              onChanged: (data) {
                setState(() {
                  filteredProductList = productList
                      .where((product) => product.description
                          .toLowerCase()
                          .contains(productnameController.text.toLowerCase()))
                      .toList();
                });
              },
              controller: productnameController,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: filteredProductList.length,
                  itemBuilder: (context, index) {
                    if (index < productList.length) {
                      return ItemContainer(
                        product: filteredProductList[index],
                      );
                    } else {
                      // Handle index out of bounds, possibly show an error message or a default widget
                      return const SizedBox
                          .shrink(); // or any other default widget
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:medi_deliver/component/ProductWidget.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/dummy_product_list.dart';
import 'package:medi_deliver/model/product.dart';
import 'package:medi_deliver/provider/userProvider.dart';
import 'package:medi_deliver/screens/itemPage.dart';
import 'package:medi_deliver/screens/searchPage.dart';
import 'package:medi_deliver/model/user.dart' as model;
import 'package:provider/provider.dart';

class homPage extends StatelessWidget {
  const homPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    model.User? loggedInUser = Provider.of<UserProvider>(context).loggedInUser;
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border(
                          left: BorderSide(
                        color: buttonColor,
                        width: 2,
                      )),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CachedNetworkImage(
                        imageUrl: loggedInUser!.profileImage,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 20,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: buttonColor,
                        ),
                        errorWidget: (context, url, error) {
                          return CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('asset/images/profile.png'),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${loggedInUser.fullName ?? 'Guest'}',
                          style: const TextStyle(
                            fontFamily: fontFamilyString,
                            fontSize: 18,
                            color: buttonColor,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'asset/images/map.png',
                              width: 20,
                            ),
                            Text(
                              loggedInUser.address ?? '',
                              style: const TextStyle(
                                fontFamily: 'DINNextLTW23s',
                                fontSize: 15,
                                color: fontSecondaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Image.asset('asset/images/notification.png')
                ],
              ),
              SizedBox(
                height: 10,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(),
                      ));
                },
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Search For A medicine A specific Product',
                      hintStyle: const TextStyle(
                        fontFamily: fontFamilyString,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                      prefixIcon: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(),
                                ));
                          },
                          icon: Image.asset('asset/images/search.png'))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // image Slider
              ImageSlideshow(
                  indicatorColor: Colors.blueGrey,
                  indicatorBackgroundColor:
                      const Color.fromARGB(255, 213, 213, 213),
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset(
                        'asset/images/slide.png',
                        width: 1,
                      ),
                    ),
                    Image.asset('asset/images/slide2.png'),
                    Image.asset('asset/images/slide3.png'),
                    Image.asset('asset/images/slide4.png'),
                  ]),
              const SizedBox(
                height: 10,
              ),
              //--------------Start of Categories-------------------------
              Container(
                alignment: Alignment.centerLeft,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: fontFamilyString,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 130,
                child: StreamBuilder<List<Map<String, String>>>(
                    stream: fetchCategoriesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: buttonColor,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        categoriesList = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoriesList.length,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              name: categoriesList[index]["name"]!,
                              imagePath: categoriesList[index]["image"]!,
                              onTap: () {
                                categoryList = productList
                                    .where((product) =>
                                        product.category.toLowerCase() ==
                                        categoriesList[index]["name"]!
                                            .toLowerCase())
                                    .toList();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemsPage(
                                      products: categoryList,
                                      categoryName: categoriesList[index]
                                          ["name"]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },

                          // return CategoryCard();
                        );
                      }
                    }),
              ),
              //  -------------------------Start of Items List
              Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: const Text('Popular Products',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontFamilyString,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                child: StreamBuilder<List<Product>>(
                    stream: fetchProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: buttonColor,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        productList = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ProductWidget(
                                product: productList[index],
                              ),
                            );
                          },
                        );
                      }
                    }),
              )
            ],
          )),
    );
    // );
  }
}

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  String name;
  final VoidCallback onTap;

  String imagePath;
  CategoryCard({
    required this.onTap,
    required this.name,
    required this.imagePath,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: fontFamilyString,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:medi_deliver/component/ProductWidget.dart';
import 'package:medi_deliver/dummy_product_list.dart';

class homPage extends StatelessWidget {
  homPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Color(0xFF34D49E), // Set the desired color
        unselectedItemColor: Colors.grey,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_comment_outlined),
            label: "Comments",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        onTap: (index) {},
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          'asset/images/blank-profile-picture-973460_960_720.webp'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hi, Ahmed'),
                          Text('Assiut, Assiut city')
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(Icons.add_alert)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Search For A medicine A specific Product',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.qr_code_scanner)),
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_rounded,
                            size: 40,
                          ))),
                ),
                SizedBox(
                  height: 20,
                ),
                // image Slider
                ImageSlideshow(
                    indicatorColor: const Color(0xFF34D49E),
                    indicatorBackgroundColor: Colors.grey,
                    autoPlayInterval: 3000,
                    isLoop: true,
                    children: [
                      Image.asset('asset/images/categories/category3.png'),
                      Image.asset('asset/images/categories/category4.jpg'),
                      Image.asset('asset/images/categories/category1.jpg'),
                      Image.asset('asset/images/categories/category2.jpg'),
                    ]),
                SizedBox(
                  height: 10,
                ),
                //--------------Start of Categories-------------------------
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'More',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Card(
                                    color: Colors.grey[200],
                                    child: Image.asset(
                                      'asset/images/fawry.png',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Text(
                              'Pand',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                //  -------------------------Start of Items List
                Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.centerLeft,
                  child: Text('Products',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ProductWidget(
                          description: productList[index]["description"],
                          price: double.parse(
                              productList[index]["price"].toString()),
                          imagePath: productList[index]["imagePath"],
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}

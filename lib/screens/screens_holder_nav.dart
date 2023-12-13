import 'package:flutter/material.dart';
import 'package:medi_deliver/screens/HomePage.dart';
import 'package:medi_deliver/screens/hom_page.dart';
import 'package:medi_deliver/screens/not_usable_screens/cart_screen.dart';

class ScreensHolderNav extends StatefulWidget {
  @override
  _ScreensHolderNavState createState() => _ScreensHolderNavState();
}

class _ScreensHolderNavState extends State<ScreensHolderNav> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    homPage(),
    HomePageScreen(),
    CartScreen(),
    homPage(),

    //orders here,
    //cart here,
    //profile here,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Color(0xFF34D49E), // Set the desired color
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), // Change to the Shopping Bag icon
            label: "Orders", // Change the label to "Orders"
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
      ),
    );
  }
}

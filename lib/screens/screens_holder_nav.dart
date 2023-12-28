import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/screens/cartPage.dart';
import 'package:medi_deliver/screens/hom_page.dart';
import 'package:medi_deliver/screens/orderPage.dart';
import 'package:medi_deliver/screens/profilePage.dart';

class ScreensHolderNav extends StatefulWidget {
  const ScreensHolderNav({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreensHolderNavState createState() => _ScreensHolderNavState();
}

class _ScreensHolderNavState extends State<ScreensHolderNav> {
  int _currentIndex = 0;
  final List<String> _selectedImages = [
    'asset/images/home_selected.png',
    'asset/images/orders_selected.png',
    'asset/images/cart_selected.png',
    'asset/images/profile_selected.png',
  ];

  final List<String> _unselectedImages = [
    'asset/images/home.png',
    'asset/images/orders.png',
    'asset/images/cart.png',
    'asset/images/profile_icon.png',
  ];
  final List<Widget> _screens = [
    const homPage(),
    OrderPage(),
    CartPage(),
    const ProfilePage(),

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
        selectedItemColor: buttonColor, // Set the desired color
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 0 ? _selectedImages[0] : _unselectedImages[0],
              width: 24,
              height: 24,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 1 ? _selectedImages[1] : _unselectedImages[1],
              width: 24,
              height: 24,
            ),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 2 ? _selectedImages[2] : _unselectedImages[2],
              width: 24,
              height: 24,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 3 ? _selectedImages[3] : _unselectedImages[3],
              width: 24,
              height: 24,
            ),
            label: "Account",
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontFamily: fontFamilyString,
          fontSize: 16,
        ),
      ),
    );
  }
}

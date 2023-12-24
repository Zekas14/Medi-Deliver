import 'package:flutter/material.dart';

GlobalKey<FormState> formkey = GlobalKey();
const Color outlineBorderColor = Color.fromARGB(255, 223, 222, 222);
const buttonColor = Color(0xFF34D49E);
const Color backgroundColor = Colors.white;
const Color fontprimaryColor = Color.fromRGBO(23, 43, 77, 1);
const Color fontSecondaryColor = Color.fromARGB(255, 122, 134, 154);
const Color secondaryColor = Color.fromARGB(255, 239, 240, 241);
const String fontFamilyString = 'DINNextLTW23';
const Color linksColor = Color.fromARGB(255, 250, 132, 70);
Color errorColor = const Color.fromARGB(255, 202, 31, 18);
const requiredSign = Text(
  " *",
  style: TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamilyString,
  ),
);
Text label(String text, {double fontSize = 16}) {
  return Text(
    text,
    style: TextStyle(
      color: fontSecondaryColor,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamilyString,
      fontSize: fontSize,
    ),
  );
}

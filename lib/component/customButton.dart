import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  final Color color ; 
  VoidCallback? onTap;
  CustomButton({super.key, required this.text, this.color = buttonColor ,this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          top: 5,
          bottom: 20,
          left: 10,
        ),
        width: double.infinity,
        height: 60,
        decoration:  BoxDecoration(
          color:color,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'DINNextLTW23',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

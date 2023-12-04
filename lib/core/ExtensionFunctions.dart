import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showCustomSnackBar({
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
  void showCustomDialog(List<Widget> list) {
    showDialog(
      context: this,
      barrierDismissible: false, // prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: list,
          ),
        );
      },
    );
  }
}

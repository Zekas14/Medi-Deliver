import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  bool? obscureText;
  Function(String)? onChanged;
  MyTextField({super.key, this.hintText, this.obscureText, this.onChanged});
  OutlineInputBorder _customOutlinedBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: TextField(
        obscureText: obscureText!,
        onChanged: (data) => onChanged!(data),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          focusedBorder: _customOutlinedBorder(Colors.lightBlue),
          enabledBorder: _customOutlinedBorder(Colors.white),
          border: _customOutlinedBorder(Colors.white),
        ),
      ),
    );
  }
}

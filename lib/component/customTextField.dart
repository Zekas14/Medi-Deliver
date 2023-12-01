import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFeild extends StatefulWidget {
  String? prefiximagePath;
  String? suffiximagePath;
  String? hintText;
  bool? obscureText;

  CustomTextFeild({
    super.key,
    this.prefiximagePath,
    this.hintText,
    this.suffiximagePath,
    this.obscureText,
  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 10,
        bottom: 5,
      ),
      child: TextField(
        obscureText: widget.obscureText!,
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 239, 240, 241),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF7A869A),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: widget.hintText,
            suffixIcon: widget.suffiximagePath != null
                ? GestureDetector(
                    child: Image.asset(widget.suffiximagePath!),
                    onTap: () => setState(() {
                      widget.obscureText = !widget.obscureText!;
                    }),
                  )
                : null,
            prefixIcon: Image.asset(widget.prefiximagePath!),
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 176, 176, 176),
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ), // Adjust the vertical padding
            prefixIconConstraints: const BoxConstraints(
              minWidth: 50, // Adjust the minimum height of the prefixIcon
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 18,
            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 50,
              minWidth: 60,
            )),
      ),
    );
  }
}

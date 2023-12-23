// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFeild2 extends StatefulWidget {
  final String? prefiximagePath;
  final String? suffiximagePath;
  final String? hintText;
  bool? obscureText;
  final Color? borderColor; // New property for border color
  final Function(String)? onChanged;

  CustomTextFeild2({
    Key? key,
    this.prefiximagePath,
    this.hintText,
    this.suffiximagePath,
    this.obscureText,
    this.borderColor = Colors.white, // Required border color
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextFeild2> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is Required';
        }
      },
      onChanged: widget.onChanged,
      obscureText: widget.obscureText!,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 239, 240, 241),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: widget.borderColor!), // Set border color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: widget.borderColor!),
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
        prefixIcon: widget.prefiximagePath != null
            ? Image.asset(widget.prefiximagePath!)
            : null,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 176, 176, 176),
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 50,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 50,
          minWidth: 60,
        ),
      ),
    );
  }
}

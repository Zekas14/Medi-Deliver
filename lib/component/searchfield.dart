import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.onChanged,
    this.controller,
    this.autofocus = true,
    this.textStyle,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.validator,
  }) : super(
          key: key,
        );
  final Function(String)? onChanged;


  final TextEditingController? controller;


  final bool? autofocus;

  final TextStyle? textStyle;


  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: textStyle,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: controller,
      onChanged: onChanged,
      autofocus: true,
      decoration: InputDecoration(
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
      ),
    );

      }
}

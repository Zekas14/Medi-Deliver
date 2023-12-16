import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
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

    //   return alignment != null
    //       ? Align(
    //           alignment: alignment ?? Alignment.center,
    //           child: textFormFieldWidget,
    //         )
    //       : textFormFieldWidget;
    // }

    // Widget get textFormFieldWidget => SizedBox(
    //       width: width ?? double.maxFinite,
    //       child: TextFormField(
    //         onChanged: onChanged,
    //         controller: controller,
    //         focusNode: focusNode ?? FocusNode(),
    //         autofocus: autofocus!,
    //         style: textStyle,
    //         obscureText: obscureText!,
    //         textInputAction: textInputAction,
    //         keyboardType: textInputType,
    //         maxLines: maxLines ?? 1,
    //         decoration: decoration,
    //         validator: validator,
    //       ),
    //     );
    // InputDecoration get decoration => InputDecoration(
    //       hintText: hintText ?? "",
    //       hintStyle: hintStyle,
    //       prefixIcon: prefix,
    //       prefixIconConstraints: prefixConstraints,
    //       suffixIcon: suffix,
    //       suffixIconConstraints: suffixConstraints,
    //       isDense: true,
    //       contentPadding: contentPadding,
    //       fillColor: fillColor,
    //       filled: filled,
    //       border: borderDecoration ??
    //           OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //             borderSide: BorderSide(
    //               color: backgroundColor,
    //               width: 1,
    //             ),
    //           ),
    //       enabledBorder: borderDecoration ??
    //           OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //             borderSide: BorderSide(
    //               width: 1,
    //             ),
    //           ),
    //       focusedBorder: borderDecoration ??
    //           OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //             borderSide: BorderSide(
    //               width: 1,
    //             ),
    //           ),
    //     );
  }
}

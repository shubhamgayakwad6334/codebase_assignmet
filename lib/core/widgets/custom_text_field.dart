import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.validator,
    this.prefixIcon,
    required this.textInputAction,
    this.obscureText = false,
    this.label,
    this.maxLines,
  });
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? label;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: FocusNode(),
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        hintText: hint,
        alignLabelWithHint: maxLines != null && maxLines! > 1,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
      textInputAction: textInputAction,
    );
  }
}

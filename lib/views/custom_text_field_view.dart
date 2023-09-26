import 'package:flutter/material.dart';

class CustomTextFieldView extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;

  const CustomTextFieldView({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.next,
      maxLines: maxLines,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}

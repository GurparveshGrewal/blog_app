import 'package:flutter/material.dart';

class BlogTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const BlogTextFieldWidget(
      {required this.controller, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
    );
  }
}

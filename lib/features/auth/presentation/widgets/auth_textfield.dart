import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final bool isPassword;
  final bool isEmail;
  final String hintText;
  final TextEditingController controller;
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isEmail = false,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isPassword,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          if (isEmail && !value!.trim().contains("@")) {
            return "invalid email";
          }
          return "$hintText is missing or invalid!";
        }
        return null;
      },
    );
  }
}

import 'package:blog_app/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const AuthGradientButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.gradient1,
            AppColors.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(
              395,
              55,
            ),
            backgroundColor: AppColors.transparentColor,
            shadowColor: AppColors.transparentColor,
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )),
    );
  }
}

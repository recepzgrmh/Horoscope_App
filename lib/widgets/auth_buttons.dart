import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'custom_button.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const AuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: label,
      onPressed: onPressed,
      backgroundColor:
          isPrimary ? AppColors.accentColor : AppColors.deactiveButton,
      foregroundColor: isPrimary ? Colors.white : AppColors.primaryColor,
    );
  }
}

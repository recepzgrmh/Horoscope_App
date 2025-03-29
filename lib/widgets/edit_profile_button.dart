import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import 'custom_button.dart';

class EditProfileButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditProfileButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomButton(
        label: 'Profili Düzenle',
        onPressed: onPressed,
        backgroundColor: AppColors.deactiveButton,
        foregroundColor: AppColors.primaryColor,
      ),
    );
  }
}

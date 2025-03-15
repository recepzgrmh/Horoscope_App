import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.primaryColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
          letterSpacing: 1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: AppColors.accentColor,
          letterSpacing: 1.5,
        ),
        displaySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.accentColor,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: AppColors.textSecondary,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
      ),
      cardTheme: CardTheme(
        color: AppColors.cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(color: AppColors.borderColor, width: 1.5),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }
}

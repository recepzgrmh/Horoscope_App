import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark, // Karanlık mod olarak ayarlandı
      scaffoldBackgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.primaryColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Renkler override edildi
          letterSpacing: 1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 1.5,
        ),
        displaySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(179, 255, 255, 255), // Değiştirildi
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: Colors.white, // Değiştirildi
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: const Color.fromARGB(179, 255, 255, 255),
        ), // Değiştirildi
      ),
      cardTheme: CardTheme(
        color: AppColors.cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: AppColors.borderColor, width: 1.5),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundColor,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}

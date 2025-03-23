import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  // Stil parametreleri (Orijinal ElevatedButton.styleFrom(...) değerleri)
  final Color backgroundColor;
  final Color foregroundColor;
  final double verticalPadding;
  final double minHeight;
  final double elevation;
  final BorderRadiusGeometry borderRadius;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.verticalPadding = 16.0,
    this.minHeight = 48.0,
    this.elevation = 3.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        minimumSize: Size.fromHeight(minHeight),
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Text(label, style: textStyle),
    );
  }
}

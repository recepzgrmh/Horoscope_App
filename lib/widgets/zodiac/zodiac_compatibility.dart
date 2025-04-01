import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';

class ZodiacCompatibility extends StatelessWidget {
  final String zodiacName;

  const ZodiacCompatibility({super.key, required this.zodiacName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$zodiacName Compatibility',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$zodiacName burcu için uyumlu burçlar ve ilişkisel dinamikler burada anlatılacak.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 30),
          _compatibilityChart(),
        ],
      ),
    );
  }

  Widget _compatibilityChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _compatibilityRow(Icons.favorite, 'Gemini, Libra, and Sagittarius.'),
        _compatibilityRow(Icons.work, 'Gemini, Libra, and Aries'),
        _compatibilityRow(
          Icons.diversity_1_rounded,
          'Gemini, Libra, and Sagittarius',
        ),
      ],
    );
  }

  Widget _compatibilityRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentColor),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(color: AppColors.textPrimary)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/utils/zodiac_data.dart';

class ZodiacOverview extends StatelessWidget {
  final String zodiacName;

  const ZodiacOverview({super.key, required this.zodiacName});

  @override
  Widget build(BuildContext context) {
    final String overviewText = getZodiacOverview(zodiacName);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${zodiacName.capitalized}',
            style: TextStyle(
              fontSize: 24,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            overviewText,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

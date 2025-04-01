import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';

class ZodiacOverview extends StatelessWidget {
  final String zodiacName;

  const ZodiacOverview({super.key, required this.zodiacName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'General Information about $zodiacName',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$zodiacName burcu hakkında detaylı bilgiler burada yer alacak.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

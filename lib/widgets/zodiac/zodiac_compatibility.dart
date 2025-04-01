import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/utils/zodiac_data.dart';

class ZodiacCompatibility extends StatelessWidget {
  final String zodiacName;

  const ZodiacCompatibility({super.key, required this.zodiacName});

  @override
  Widget build(BuildContext context) {
    // Her kategori için uyumlu burçları çekip virgülle ayırıyoruz
    final String loveCompatible = getCompatibleZodiacs(
      zodiacName,
      'love',
    ).join(', ');
    final String workCompatible = getCompatibleZodiacs(
      zodiacName,
      'work',
    ).join(', ');
    final String friendshipCompatible = getCompatibleZodiacs(
      zodiacName,
      'friendship',
    ).join(', ');

    // Her kategori için uyumsuz burçları çekip virgülle ayırıyoruz
    final String loveIncompatible = getIncompatibleZodiacs(
      zodiacName,
      'love',
    ).join(', ');
    final String workIncompatible = getIncompatibleZodiacs(
      zodiacName,
      'work',
    ).join(', ');
    final String friendshipIncompatible = getIncompatibleZodiacs(
      zodiacName,
      'friendship',
    ).join(', ');

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${zodiacName.capitalized} Compatibility & Incompatibility',
            style: TextStyle(
              fontSize: 24,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${zodiacName.capitalized} burcu için uyumlu ve uyumsuz burçlar aşağıda listelenmiştir.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
          const SizedBox(height: 30),
          Text(
            'Compatible:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          _compatibilityChart(
            loveCompatible,
            workCompatible,
            friendshipCompatible,
          ),
          const SizedBox(height: 20),
          Text(
            'Incompatible:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          _compatibilityChart(
            loveIncompatible,
            workIncompatible,
            friendshipIncompatible,
          ),
        ],
      ),
    );
  }

  Widget _compatibilityChart(String love, String work, String friendship) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _compatibilityRow(Icons.favorite, love),
        _compatibilityRow(Icons.work, work),
        _compatibilityRow(Icons.diversity_1_rounded, friendship),
      ],
    );
  }

  Widget _compatibilityRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accentColor),
          const SizedBox(width: 10),
          Flexible(
            child: Text(text, style: TextStyle(color: AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }
}

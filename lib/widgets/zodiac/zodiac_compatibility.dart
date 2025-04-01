import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/utils/zodiac_data.dart';

class ZodiacCompatibility extends StatelessWidget {
  final String zodiacName;

  const ZodiacCompatibility({super.key, required this.zodiacName});

  @override
  Widget build(BuildContext context) {
    // Her kategori için uyumlu burçları çekiyoruz ve virgülle ayırarak metin haline getiriyoruz.
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

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${zodiacName.capitalized} Compatibility',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${zodiacName.capitalized} burcu için uyumlu burçlar ve ilişkisel dinamikler aşağıda listelenmiştir.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 30),
          _compatibilityChart(
            loveCompatible,
            workCompatible,
            friendshipCompatible,
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

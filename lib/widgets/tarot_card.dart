import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/screens/tarot_detailScreen.dart';

class TarotCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const TarotCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => TarotDetailScreen(
                  title: title,
                  subtitle: subtitle,
                  imagePath: imagePath,
                ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16.0),
      splashColor: AppColors.primaryColor.withOpacity(0.2),
      child: Card(
        color: AppColors.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: AppColors.borderColor, width: 1.5),
        ),
        elevation: 4,
        shadowColor: AppColors.secondaryColor.withOpacity(0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

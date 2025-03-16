import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';

class TarotDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const TarotDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.accentColor,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

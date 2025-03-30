import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/carousel_widget.dart';
import 'package:horoscope/widgets/social_widget.dart';
import 'package:horoscope/widgets/tarot_card.dart';
import '../screens/zodiac_detail_screen.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  // 📌 Otomatik Zodiac Resim Listesi
  static const List<String> zodiacSigns = [
    "aquarius",
    "aries",
    "cancer",
    "capricorn",
    "gemini",
    "leo",
    "libra",
    "pisces",
    "sagittarius",
    "scorpio",
    "taurus",
    "virgo",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // SingleChildScrollView ekleyerek ekranların taşmasını engelledik
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCarouselSection(context),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
            child: SocialWidget(),
          ),
          _buildCommunitySection(context),
        ],
      ),
    );
  }

  // Carousel bölümünü ayrı metotla oluşturduk
  Widget _buildCarouselSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Carousel Başlık
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
          child: Text(
            'Carousel View',
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        // Carousel İçeriği
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CarouselWidget(
            itemExtent: 330,
            children: const [
              TarotCard(
                title: "Daily Horoscope",
                subtitle: "What does the day have in store for you?",
                imagePath: "assets/images/daily.png",
              ),
              TarotCard(
                title: "Weekly Horoscope",
                subtitle:
                    "The universe has a message for your next seven days.",
                imagePath: "assets/images/weekly.png",
              ),
              TarotCard(
                title: "Monthly Horoscope",
                subtitle: "Use your energy wisely throughout the month.",
                imagePath: "assets/images/monthly.png",
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Community bölümünü ayrı metotla oluşturduk
  Widget _buildCommunitySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          // Başlık
          Text(
            'Community',
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          Text(
            'Connect with Others Who Share Your Sign',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 12),
          // Zodiac Grid
          _buildZodiacGrid(context),
        ],
      ),
    );
  }

  Widget _buildZodiacGrid(BuildContext context) {
    return Column(
      children:
          zodiacSigns
              .map((imageName) => ZodiacCard(imageName: imageName))
              .toList(),
    );
  }
}

// Burç kartı için ayrı widget
class ZodiacCard extends StatelessWidget {
  final String imageName;

  const ZodiacCard({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ZodiacDetailScreen(
                      zodiacName: imageName,
                      imagePath: "assets/images/zodiac-signs/$imageName.jpeg",
                    ),
                fullscreenDialog: true,
              ),
            );
          },
          child: Stack(
            children: [
              // Resim
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/zodiac-signs/$imageName.jpeg",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // Üstüne Metin
              Positioned(
                left: 20,
                bottom: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    imageName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/carousel_widget.dart';
import 'package:horoscope/widgets/social_widget.dart';
import 'package:horoscope/widgets/tarot_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 📌 Carousel Başlık
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

        // 📌 Carousel İçeriği
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CarouselWidget(
            itemExtent: 330,
            children: [
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

        // 📌 Social Bölümü
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
          child: SocialWidget(),
        ),

        // 📌 Community Bölümü (Resmin Üzerine Yazı Eklenmiş Hali)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 12),

              // 📌 Resim Üstüne Metin Eklenen Stack
              Stack(
                children: [
                  // Arka Plan Resmi
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/weekly.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Üstteki Metin
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
                      child: const Text(
                        'Discover What the Community is Saying',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

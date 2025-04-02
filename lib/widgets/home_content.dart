import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/services/user_sevice.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/carousel_widget.dart';
import 'package:horoscope/widgets/social_widget.dart';
import 'package:horoscope/widgets/tarot_card.dart';
import '../screens/zodiac/zodiac_detail_screen.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  // Automatic Zodiac image list
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
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool isLoading = false;
  String? userZodiac;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Loads user data from Firestore using UserService.
  Future<void> _loadUserData() async {
    setState(() => isLoading = true);
    final data = await UserService.getUserData();
    if (data != null) {
      // Assuming the Firestore document contains a field named "zodiacSign"
      userZodiac = data['zodiacSign'] as String?;
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userZodiac == null || userId == null) {
      return const Center(child: Text('Kullanıcı bilgisi alınamadı.'));
    }

    return SingleChildScrollView(
      // Prevent content overflow
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

  // Build the carousel section with TarotCard widgets that receive the user's zodiac and userId.
  Widget _buildCarouselSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselWidget(
        itemExtent: 330,
        children: [
          TarotCard(
            title: "Daily Horoscope",
            subtitle: "What does the day have in store for you?",
            imagePath: "assets/images/daily.png",
            zodiac: userZodiac!,
            userId: userId!,
          ),
          TarotCard(
            title: "Weekly Horoscope",
            subtitle: "The universe has a message for your next 7 days.",
            imagePath: "assets/images/weekly.png",
            zodiac: userZodiac!,
            userId: userId!,
          ),
          TarotCard(
            title: "Monthly Horoscope",
            subtitle: "Use your energy wisely throughout the month.",
            imagePath: "assets/images/monthly.png",
            zodiac: userZodiac!,
            userId: userId!,
          ),
        ],
      ),
    );
  }

  // Build the community section containing a zodiac grid.
  Widget _buildCommunitySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          // Section Title
          const Text(
            'Community',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          const Text(
            'Connect with Others Who Share Your Sign',
            style: TextStyle(
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
          HomeContent.zodiacSigns
              .map((imageName) => ZodiacCard(imageName: imageName))
              .toList(),
    );
  }
}

// ZodiacCard widget displays each zodiac image with an overlay text and navigates to ZodiacDetailScreen.
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
              // Display the zodiac image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/zodiac-signs/$imageName.jpeg",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // Overlay text on the image
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

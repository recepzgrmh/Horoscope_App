import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/tarot_card.dart';
import 'package:horoscope/widgets/custom_appbar.dart';
import 'package:horoscope/widgets/bottom_nav.dart';
import 'package:horoscope/screens/profile_screen.dart';
import 'package:horoscope/screens/readings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Seçili butonun index'ini tutuyor

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Örneğin index 1 ReadingsScreen, index 2 ProfileScreen'e karşılık geliyor
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ReadingsScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.backgroundColor,
            title: const Text("Home"),
            // Eğer CustomAppBar kullanmak isterseniz, buraya sabit opaklıkta ekleyebilirsiniz.
            // flexibleSpace: CustomAppBar(opacity: 1.0),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TarotCard(
                  title: "Daily Horoscope",
                  subtitle: "What does the day have in store for you?",
                  imagePath: "assets/images/daily.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TarotCard(
                  title: "Weekly Horoscope",
                  subtitle:
                      "The universe has a message for your next seven days.",
                  imagePath: "assets/images/weekly.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TarotCard(
                  title: "Monthly Horoscope",
                  subtitle: "Use your energy wisely throughout the month.",
                  imagePath: "assets/images/monthly.png",
                ),
              ),
            ]),
          ),
        ],
      ),

      // Artık HomeScreen'de animasyon kullanılmadığı için,
      // BottomNavBar'a animationController parametresi null gönderiliyor.
      backgroundColor: AppColors.backgroundColor,
    );
  }
}

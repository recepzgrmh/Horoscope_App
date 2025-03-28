import 'package:flutter/material.dart';
import 'package:horoscope/screens/main_screen.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/tarot_card.dart';
import 'package:horoscope/widgets/custom_appbar.dart';
import 'package:horoscope/widgets/bottom_nav.dart';
import 'package:horoscope/screens/profile_screen.dart';
import 'package:horoscope/screens/readings_screen.dart';

class AnimatedHomeScreen extends StatefulWidget {
  const AnimatedHomeScreen({super.key});

  @override
  _AnimatedHomeScreenState createState() => _AnimatedHomeScreenState();
}

class _AnimatedHomeScreenState extends State<AnimatedHomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  bool _showBottomNav = false;
  int _currentIndex = 0; // Seçili butonun index'ini tutuyor

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      double appBarHeight = MediaQuery.of(context).size.height - kToolbarHeight;
      bool shouldShowBottomNav = offset >= appBarHeight - kToolbarHeight;

      if (shouldShowBottomNav != _showBottomNav) {
        setState(() {
          _showBottomNav = shouldShowBottomNav;
        });

        if (shouldShowBottomNav) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    }
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Geçişi kullanıcı tıklaması ile gerçekleştiriyoruz:
    // AnimatedHomeScreen'de bottom nav tıklandığında MainScreen'e geçiş yapıp,
    // seçilen indeksi aktaracağız.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(initialIndex: index)),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.backgroundColor,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                double percent =
                    (constraints.maxHeight - kToolbarHeight) /
                    (MediaQuery.of(context).size.height - kToolbarHeight);
                double opacity = percent.clamp(0.0, 1.0);
                return CustomAppBar(opacity: opacity);
              },
            ),
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
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child:
            _showBottomNav
                ? BottomNavBar(
                  animationController: _animationController,
                  currentIndex: _currentIndex,
                  onTap: _onBottomNavTapped,
                )
                : const SizedBox.shrink(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horoscope/screens/chat_screen.dart';
import 'package:horoscope/screens/feed_screen.dart';
import 'package:horoscope/screens/home_screen.dart';
import 'package:horoscope/screens/profile_screen.dart';
import 'package:horoscope/screens/readings_screen.dart';
import 'package:horoscope/widgets/bottom_nav.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _animationController;
  late PageController _pageController;

  final List<Widget> _screens = const [
    HomeScreen(),
    FeedScreen(),
    ReadingsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // Nav bar her zaman görünür
    _animationController.value = 1.0;
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Geri tuşuna basıldığında; eğer HomeScreen dışında isek ana sayfaya geç,
  // aksi halde uygulamayı kapatmasına izin ver.
  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      _onBottomNavTapped(0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
        ),
        bottomNavigationBar: BottomNavBar(
          animationController: _animationController,
          currentIndex: _currentIndex,
          onTap: _onBottomNavTapped,
        ),
      ),
    );
  }
}

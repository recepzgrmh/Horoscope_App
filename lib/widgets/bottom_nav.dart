import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final AnimationController animationController;

  const BottomNavBar({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1), // Başlangıçta ekran dışında (aşağıda)
        end: Offset.zero, // Son durumda normal konumda olacak
      ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.cardColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.comment), label: 'Readings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

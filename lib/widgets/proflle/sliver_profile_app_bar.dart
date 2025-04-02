// sliver_profile_app_bar.dart
import 'package:flutter/material.dart';
import 'package:horoscope/screens/main_screen.dart';
import 'profile_flexible_space.dart';
import 'profile_tab_bar.dart';

class SliverProfileAppBar extends StatelessWidget {
  final Map<String, dynamic> userData;
  final TabController tabController;

  const SliverProfileAppBar({
    super.key,
    required this.userData,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 500.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 30),
        onPressed: () {
          debugPrint("Back button pressed. Checking navigator stack...");
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
            debugPrint("Navigator.pop() çağrıldı.");
          } else {
            debugPrint("Geri dönecek rota yok. MainScreen'e yönlendiriliyor.");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        },
      ),
      flexibleSpace: ProfileFlexibleSpace(userData: userData),
      bottom: ProfileTabBar(tabController: tabController),
    );
  }
}

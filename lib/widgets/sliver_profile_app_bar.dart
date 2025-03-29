import 'package:flutter/material.dart';
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
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: ProfileFlexibleSpace(
        userData: userData,
      ), // 📌 Blur + Animasyon Çalışacak
      bottom: ProfileTabBar(tabController: tabController),
    );
  }
}

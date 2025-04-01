import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';

class ProfileTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const ProfileTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: AppColors.accentColor,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(text: 'Paylaşımlar'),
        Tab(text: 'Bilgiler'),
        Tab(text: 'Beğeniler'),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'zodiac_overview.dart';
import 'zodiac_compatibility.dart';

class ZodiacTabs extends StatelessWidget {
  final TabController tabController;
  final String zodiacName;

  const ZodiacTabs({
    super.key,
    required this.tabController,
    required this.zodiacName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // 📌 HATA ÇÖZÜMÜ
      children: [
        TabBar(
          controller: tabController,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Compatibility'),
            Tab(text: 'People'),
          ],
        ),
        Flexible(
          // 📌 HATA ÇÖZÜMÜ
          child: TabBarView(
            controller: tabController,
            children: [
              ZodiacOverview(zodiacName: zodiacName),
              ZodiacCompatibility(zodiacName: zodiacName),
              const Center(child: Text("People Content")),
            ],
          ),
        ),
      ],
    );
  }
}

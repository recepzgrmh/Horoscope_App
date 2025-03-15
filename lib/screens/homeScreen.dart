import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/tarotCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildFlexibleSpace(BuildContext context, BoxConstraints constraints) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double percent =
        (constraints.maxHeight - kToolbarHeight) / (maxHeight - kToolbarHeight);
    final double opacity = percent.clamp(0.0, 1.0);

    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: opacity,
          child: Image.asset(
            'assets/images/home-screen.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(color: AppColors.backgroundColor.withOpacity(0.7 * opacity)),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Opacity(
              opacity: opacity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Daily Tarot',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Readings',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Unveil the mysteries the universe holds for you today.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: (_) => false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.7,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.backgroundColor,
              flexibleSpace: LayoutBuilder(
                builder:
                    (context, constraints) => FlexibleSpaceBar(
                      background: _buildFlexibleSpace(context, constraints),
                    ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TarotCard(),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TarotCard(),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TarotCard(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/tarotCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          return false;
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight:
                  MediaQuery.of(context).size.height, // Tam ekran açılış
              floating: false,
              pinned: true,
              backgroundColor: AppColors.backgroundColor,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // Yüksekliği hesapla
                  double percent =
                      (constraints.maxHeight - kToolbarHeight) /
                      (MediaQuery.of(context).size.height - kToolbarHeight);

                  // Resim kaybolma animasyonu (opacity)
                  double opacity = percent.clamp(0.0, 1.0);

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
                      Container(
                        color: AppColors.backgroundColor.withOpacity(
                          0.8 * opacity,
                        ), // Mistik gölge efekti
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Opacity(
                            opacity: opacity, // Kaydırdıkça başlık da kaybolur
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Daily Tarot',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    letterSpacing: 1.5,
                                    color: AppColors.primaryColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Readings',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    letterSpacing: 1.5,
                                    color: AppColors.accentColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Unveil the mysteries the universe holds for you today.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
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
      backgroundColor: AppColors.backgroundColor,
    );
  }
}

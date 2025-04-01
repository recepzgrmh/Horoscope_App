import 'package:flutter/material.dart';
import 'package:horoscope/screens/zodiac_detail_screen.dart';
import 'package:horoscope/styles/app_colors.dart';

class ReadingsScreen extends StatelessWidget {
  const ReadingsScreen({super.key});

  static const List<String> zodiacSigns = [
    "aquarius",
    "aries",
    "cancer",
    "capricorn",
    "gemini",
    "leo",
    "libra",
    "pisces",
    "sagittarius",
    "scorpio",
    "taurus",
    "virgo",
  ];

  // Yeni Feed mock verileri
  final List<Map<String, String>> feedPosts = const [
    {
      'username': '@astroQueen',
      'content': 'Bugün enerjin yüksek, yeni başlangıçlar için harika bir gün.',
      'time': '2m',
    },
    {
      'username': '@stargazer',
      'content': 'Gökyüzündeki yıldızlar bugünün sırlarını fısıldıyor.',
      'time': '5m',
    },
    {
      'username': '@moonwalker',
      'content': 'Ayın etkisiyle duygularınız derinleşebilir, sakin kalın.',
      'time': '10m',
    },
    {
      'username': '@sunrise',
      'content': 'Güneşin doğuşu umut ve yenilik getiriyor, ilerleyin.',
      'time': '15m',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Discover Bölümü
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join Our Community',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connect, share stories, and find advice.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),

          // Discover Görseli
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/discover.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Zodiac Bölümü Başlığı
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Zodiac Sign',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore insights from each sign.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),

          // Zodiac Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                String imageName = zodiacSigns[index];
                return GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ZodiacDetailScreen(
                                zodiacName: imageName,
                                imagePath:
                                    "assets/images/zodiac-signs/$imageName.jpeg",
                              ),
                          fullscreenDialog: true,
                        ),
                      ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "assets/images/zodiac-signs/$imageName.jpeg",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            imageName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: zodiacSigns.length),
            ),
          ),
          // Feed Bölümü Başlığı
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Latest Feed',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),

          // Feed Gönderi Listesi
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final post = feedPosts[index];
                return FeedCard(
                  username: post['username']!,
                  content: post['content']!,
                  time: post['time']!,
                );
              }, childCount: feedPosts.length),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
        ],
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final String username;
  final String content;
  final String time;

  const FeedCard({
    Key? key,
    required this.username,
    required this.content,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post başlığı: kullanıcı bilgisi ve zaman
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.accentColor,
                  child: Text(username[1].toUpperCase()),
                ),
                const SizedBox(width: 8),
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  time,
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

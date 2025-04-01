import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:get/get.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  // Örnek mock veriler
  final List<Map<String, String>> mockPosts = const [
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
    {
      'username': '@cosmicVibes',
      'content': 'Bugün evrenin enerjisini hissedin, farkındalık kazanın.',
      'time': '20m',
    },
    {
      'username': '@celestial',
      'content': 'Burcunuz size özel ipuçları veriyor, dikkatli olun.',
      'time': '25m',
    },
    {
      'username': '@lunarLight',
      'content': 'Ay ışığı rehberliğinde, içsel gücünüzü keşfedin.',
      'time': '30m',
    },
    {
      'username': '@astroGuru',
      'content': 'Horoskopunuz bugün pozitif değişimlerin habercisi.',
      'time': '35m',
    },
    {
      'username': '@zodiacMaster',
      'content': 'Yıldızlar konuşuyor: Bugün planlarınız hayata geçebilir.',
      'time': '40m',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Üstte sabit SliverAppBar
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.backgroundColor,
            title: const Text("Feed", style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
          ),
          // Arama çubuğu
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarDelegate(minExtent: 60, maxExtent: 60),
          ),
          // Gönderi (post) listesi
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final post = mockPosts[index];
                return _PostCard(
                  username: post['username']!,
                  content: post['content']!,
                  time: post['time']!,
                );
              }, childCount: mockPosts.length),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;

  _SearchBarDelegate({required this.minExtent, required this.maxExtent});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          filled: true,
          fillColor: AppColors.cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) {
    return maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent;
  }
}

class _PostCard extends StatelessWidget {
  final String username;
  final String content;
  final String time;

  const _PostCard({
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// --- Projenizdeki gerçek dosya yollarını ve renkleri kullanın ---
class AppColors {
  static const Color backgroundColor = Color(0xFF1A1A2E);
  static const Color cardColor = Color(0xFF16213E);
  static const Color accentColor = Color(0xFF00BFFF); // Örnek bir vurgu rengi
  static const Color borderColor = Colors.white24;
}
// -----------------------------------------------------------------

// Mock post model (Değişiklik yok)
class MockPost {
  final String imageUrl;
  final int likes;
  final int comments;

  const MockPost({
    required this.imageUrl,
    required this.likes,
    required this.comments,
  });
}

class UserProfile extends StatefulWidget {
  final String userEmail;
  const UserProfile({super.key, required this.userEmail});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Map<String, dynamic>? userData;

  // Örnek gönderi listesi
  final List<MockPost> _posts = List.generate(
    15,
    (index) => MockPost(
      imageUrl: 'https://picsum.photos/seed/${index + 1}/500/500',
      likes: (index + 1) * 17,
      comments: (index + 1) * 3,
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Find user by email
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: widget.userEmail)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userData = querySnapshot.docs.first.data();
        });
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:
          userData == null
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                slivers: [
                  // --- Üst Bar (AppBar) ---
                  SliverAppBar(
                    backgroundColor: AppColors.backgroundColor,
                    pinned: true,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.keyboard_backspace_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text(
                      "${userData!['fullName']} ${userData!['lastName']}",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () {
                          // Ayarlar veya diğer seçenekler için
                        },
                      ),
                    ],
                  ),

                  // --- Profil Bilgileri (Kart olmadan, düz) ---
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Foto + İstatistik
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userData!['photoUrl'] ??
                                      'https://picsum.photos/id/237/200/200',
                                ),
                                radius: 45,
                              ),
                              const SizedBox(width: 24),
                              const Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _Stat(count: 59, label: 'Gönderi'),
                                    _Stat(count: 259, label: 'Takipçi'),
                                    _Stat(count: 715, label: 'Takip'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // İsim + Burç + Bio
                          Text(
                            "${userData!['fullName']} ${userData!['lastName']}",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${userData!['zodiacSign']} Burcu ✨',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Flutter Developer | UI/UX Meraklısı\nHayatı kodlarla şekillendirmek.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Butonlar
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accentColor,
                                    foregroundColor:
                                        Colors.white, // Beyaz metin için
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 4, // Hafif bir yükselti
                                  ),
                                  child: const Text(
                                    'Takip Et',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    side: BorderSide(
                                      color: AppColors.borderColor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text('Mesaj Gönder'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}

/// İstatistik Widget'ı
class _Stat extends StatelessWidget {
  const _Stat({required this.count, required this.label});
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$count',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

/// Örnek Gönderi Grid Widget'ı
class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid({required this.posts});
  final List<MockPost> posts;

  @override
  Widget build(BuildContext context) {
    // Grid'in kenarlara yapışmaması için küçük bir padding
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        // NestedScrollView body'si içinde olduğu için
        // artık shrinkWrap veya özel physics'e gerek yok.
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          // Köşeleri hafif yuvarlatılmış resimler daha şık durur
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(posts[index].imageUrl, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/services/firebase_services.dart';
import 'package:horoscope/utils/share_post.dart';
import 'package:horoscope/styles/app_colors.dart';
import '../custom_button.dart';

class ProfileTabView extends StatefulWidget {
  final TabController tabController;

  const ProfileTabView({super.key, required this.tabController});

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {
  final currenUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(currenUser?.uid)
                        .collection('posts')
                        .orderBy('sentAt', descending: true)
                        .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Hata: ${snapshot.error}'));
                  }
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Center(child: Text('Henüz paylaşım yok.'));
                  }
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (ctx, i) {
                      final data = docs[i].data()! as Map<String, dynamic>;
                      return SharePost(
                        postMessage: data['message'] as String? ?? '',
                        user: data['userEmail'] as String? ?? 'Anonim',
                        timestamp: (data['sentAt'] as Timestamp).toDate(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundColor,
                  AppColors.cardColor.withOpacity(0.3),
                ],
              ),
            ),
            child: StreamBuilder<DocumentSnapshot>(
              stream:
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(currenUser?.uid)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Hata: ${snapshot.error}'));
                }

                final userData = snapshot.data?.data() as Map<String, dynamic>?;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            Icons.email_outlined,
                            'E-posta',
                            currenUser?.email ?? 'Belirtilmemiş',
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            Icons.person_outline,
                            'Kullanıcı Adı',
                            userData?['username'] ?? 'Belirtilmemiş',
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            Icons.calendar_today_outlined,
                            'Doğum Tarihi',
                            userData?['birthDate'] ?? 'Belirtilmemiş',
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            Icons.stars_outlined,
                            'Burç',
                            userData?['zodiacSign'] ?? 'Belirtilmemiş',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        label: 'Çıkış Yap',
                        onPressed: () => FirebaseServices.signOut(context),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const Center(child: Text('Beğeniler burada görüntülenecek.')),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentColor, size: 22),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

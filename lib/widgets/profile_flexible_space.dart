import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:horoscope/widgets/custom_button.dart';
import '../styles/app_colors.dart';

class ProfileFlexibleSpace extends StatelessWidget {
  final Map<String, dynamic> userData;
  final double expandedHeight;

  const ProfileFlexibleSpace({
    super.key,
    required this.userData,
    this.expandedHeight = 500.0,
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double collapseRange = expandedHeight - kToolbarHeight - topPadding;

    return LayoutBuilder(
      builder: (context, constraints) {
        double t = ((constraints.maxHeight - kToolbarHeight - topPadding) /
                collapseRange)
            .clamp(0.0, 1.0);

        return Stack(
          fit: StackFit.expand,
          children: [
            // 📌 NORMAL ARKA PLAN RESMİ (Tam Görünürken)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: t,
              child: Image.asset(
                'assets/images/zodiac-signs/virgo.jpeg',
                fit: BoxFit.cover,
              ),
            ),

            // 📌 BULANIK ARKA PLAN RESMİ (Küçüldüğünde Blur Efekti Verir)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: 1 - t,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ), // Blur daha smooth olacak
                child: Image.asset(
                  'assets/images/zodiac-signs/virgo.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 📌 SİYAH OVERLAY (Görselliği Güzelleştirmek İçin)
            Container(color: Colors.black.withOpacity(0.3)),

            // 📌 PROFİL BİLGİLERİ ARKA PLAN (İSMİN ALTINDAKİ BEYAZ ALAN)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              bottom: t > 0.5 ? 0 : -250, // Smooth kaybolma
              left: 0,
              right: 0,
              child: Container(
                height: 230.0,
                decoration: const BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
            ),

            // 📌 PROFİL DETAYLARI (İSİM, FOTO, EMAIL) - Smooth kaybolma/görünme
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              bottom: t > 0.5 ? 130 : -100, // Smooth geçiş
              left: 16,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: t > 0.5 ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder:
                              (_) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Hero(
                                  tag: 'profile-photo',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      'assets/images/profile.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                        );
                      },
                      child: Hero(
                        tag: 'profile-photo',
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: const AssetImage(
                            'assets/images/profile.jpg',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${userData["fullName"]} ${userData["lastName"]}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userData["email"],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 📌 PROFİL DÜZENLEME BUTONU (Yavaşça kaybolmalı)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              bottom: t > 0.5 ? 60 : -100,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: t > 0.5 ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    isPrimary: false,
                    label: 'Profili Düzenle',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

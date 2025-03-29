import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileDetails({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/zodiac-signs/virgo.jpeg', fit: BoxFit.cover),
        // Buraya profil resmini, isim, email gibi bilgileri ekle
        // Daha önce kullandığın widget'ları buraya taşı
      ],
    );
  }
}

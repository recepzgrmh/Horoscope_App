import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile", textAlign: TextAlign.center)),
      body: const Center(child: Text("Profil sayfası içeriği buraya gelecek.")),
    );
  }
}

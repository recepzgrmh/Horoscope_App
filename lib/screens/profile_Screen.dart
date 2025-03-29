import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:horoscope/opening.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<int?> calculateAge(String birthDateString) async {
    if (birthDateString.isEmpty) return null;

    DateFormat inputFormat = DateFormat('dd-MM-yyyy');
    DateTime birthDate = inputFormat.parse(birthDateString);

    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .get();

      if (doc.exists) {
        userData = doc.data() as Map<String, dynamic>;

        if ((userData?["birthDate"] ?? "").isNotEmpty) {
          int? userAge = await calculateAge(userData?["birthDate"]);

          if (userAge != null) {
            userData!["age"] = userAge.toString();

            await FirebaseFirestore.instance
                .collection("users")
                .doc(user!.uid)
                .update({"age": userAge.toString()});
          }
        }

        setState(() {});
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => const Opening()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          userData == null
              ? const Center(child: CircularProgressIndicator())
              : NestedScrollView(
                headerSliverBuilder: (_, __) => [_buildSliverAppBar()],
                body: _buildTabBarView(),
              ),
    );
  }

  static const double _expandedHeight = 500.0;
  static const double _profileContainerHeight = 230.0;

  // SliverAppBar Widget
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: _expandedHeight,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 30),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (_, constraints) => _buildFlexibleSpace(constraints),
      ),
      bottom: _buildTabBar(),
    );
  }

  // FlexibleSpace Widget
  Widget _buildFlexibleSpace(BoxConstraints constraints) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double collapseRange = _expandedHeight - kToolbarHeight - topPadding;

    double t = ((constraints.maxHeight - kToolbarHeight - topPadding) /
            collapseRange)
        .clamp(0.0, 1.0);

    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: t,
          child: Image.asset(
            'assets/images/zodiac-signs/virgo.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildProfileDetailsBackground(),
        ),
        Opacity(
          opacity: 1 - t,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Image.asset(
              'assets/images/zodiac-signs/virgo.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(color: Colors.black.withOpacity(0.3)),
        if (t > 0.5) _buildProfileDetails(),
        if (t > 0.5) _buildEditProfileButton(),
      ],
    );
  }

  // Profil bilgileri arka plan
  Widget _buildProfileDetailsBackground() {
    return Container(
      height: _profileContainerHeight,
      decoration: const BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  // Profil fotoğrafı, isim, e-posta
  Widget _buildProfileDetails() {
    return Positioned(
      bottom: 130,
      left: 16,
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
              // küçük fotoğraf da Hero ile sarılmalı
              tag: 'profile-photo', // aynı tag kullanılmalı
              child: CircleAvatar(
                radius: 40,
                backgroundImage: const AssetImage('assets/images/profile.jpg'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${userData?["fullName"] ?? "Bilgi Eksik"} ${userData?["lastName"] ?? ""}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userData?["email"] ?? "E-posta Eksik",
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Profil Düzenleme Butonu
  Widget _buildEditProfileButton() {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomButton(
          label: 'Profili Düzenle',
          onPressed: () {},
          backgroundColor: AppColors.deactiveButton,
          foregroundColor: AppColors.primaryColor,
        ),
      ),
    );
  }

  // TabBar Widget
  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.accentColor,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(text: 'Paylaşımlar'),
        Tab(text: 'Bilgiler'),
        Tab(text: 'Beğeniler'),
      ],
    );
  }

  // TabBarView Widget
  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        Center(child: Text('Paylaşımlar burada görüntülenecek.')),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: CustomButton(
              label: 'Çıkış Yap',
              onPressed: signOut,
              backgroundColor: AppColors.accentColor,
              foregroundColor: AppColors.primaryColor,
            ),
          ),
        ),
        Center(child: Text('Beğeniler burada görüntülenecek.')),
      ],
    );
  }
}

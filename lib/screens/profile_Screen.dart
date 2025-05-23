import 'package:flutter/material.dart';
import 'package:horoscope/services/firebase_services.dart';

import '../widgets/proflle/sliver_profile_app_bar.dart';
import '../widgets/proflle/profile_tab_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchUser();
  }

  Future<void> fetchUser() async {
    userData = await FirebaseServices.getUserData();
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          userData == null
              ? const Center(child: CircularProgressIndicator())
              : NestedScrollView(
                headerSliverBuilder:
                    (_, __) => [
                      SliverProfileAppBar(
                        userData: userData!,
                        tabController: _tabController,
                      ),
                    ],
                body: ProfileTabView(tabController: _tabController),
              ),
    );
  }
}

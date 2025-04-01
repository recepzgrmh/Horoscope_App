import 'package:flutter/material.dart';
import 'package:horoscope/services/firebase_services.dart';
import '../custom_button.dart';

class ProfileTabView extends StatelessWidget {
  final TabController tabController;

  const ProfileTabView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        const Center(child: Text('Paylaşımlar burada görüntülenecek.')),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: CustomButton(
              label: 'Çıkış Yap',
              onPressed: () => FirebaseServices.signOut(context),
            ),
          ),
        ),
        const Center(child: Text('Beğeniler burada görüntülenecek.')),
      ],
    );
  }
}

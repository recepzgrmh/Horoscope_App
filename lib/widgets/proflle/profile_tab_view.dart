import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/services/firebase_services.dart';
import 'package:horoscope/utils/share_post.dart';
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
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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

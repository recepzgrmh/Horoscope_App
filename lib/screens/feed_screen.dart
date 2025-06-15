// lib/screens/feed_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/utils/share_post.dart';
import 'post_feed_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser!;

  void _openPostScreen() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => const PostFeedScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Haber Akışı')),
      floatingActionButton: FloatingActionButton(
        onPressed: _openPostScreen,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text('Oturum açan: ${_currentUser.email}'),
          ),
        ],
      ),
    );
  }
}

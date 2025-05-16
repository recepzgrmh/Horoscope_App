import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/screens/main_screen.dart';
import 'package:horoscope/screens/post_feed_screen.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:http/http.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    void openPostScreen() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => PostFeedScreen(),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openPostScreen,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance
                        .collection('users posts')
                        .orderBy('sentAt', descending: false)
                        .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                    },)
                  }
                },
              ),
            ),
            Text('logged in as:${currentUser.email}'),
          ],
        ),
      ),
    );
  }
}

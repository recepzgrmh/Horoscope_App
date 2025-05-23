import 'package:flutter/material.dart';

class SharePost extends StatelessWidget {
  final String postMessage;
  final String user;

  const SharePost({super.key, required this.postMessage, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(user), Text(postMessage)]);
  }
}

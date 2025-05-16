import 'package:flutter/material.dart';

class PostFeedScreen extends StatefulWidget {
  const PostFeedScreen({super.key});

  @override
  State<PostFeedScreen> createState() => _PostFeedScreenState();
}

class _PostFeedScreenState extends State<PostFeedScreen> {
  void postMessage() {}

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,

      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 10.0),
            child: AppBar(
              actions: [
                ElevatedButton(
                  onPressed: postMessage,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Paylaş'),
                ),
              ],
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 20.0, right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.person),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLength: 240,
                  minLines: 1,
                  maxLines: null,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Neler Oluyor?',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

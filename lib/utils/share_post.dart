import 'package:flutter/material.dart';

class SharePost extends StatelessWidget {
  final String postMessage;
  final String user;

  const SharePost({super.key, required this.postMessage, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: avatar + username
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    user.isNotEmpty ? user[0].toUpperCase() : '?',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    user,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                // Buraya tarih/saat eklemek isterseniz bir Text() daha koyabilirsiniz
              ],
            ),

            const SizedBox(height: 12),

            // Post içeriği
            Text(
              postMessage,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),

            const SizedBox(height: 16),

            // Aksiyon butonları (beğen, yorum vb.)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {
                    // Beğeni işlevi buraya
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    // Yorum işlevi buraya
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

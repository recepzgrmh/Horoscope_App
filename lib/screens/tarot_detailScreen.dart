// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class TarotDetailScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const TarotDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  _TarotDetailScreenState createState() => _TarotDetailScreenState();
}

class _TarotDetailScreenState extends State<TarotDetailScreen> {
  String dailyMessage = "Bugünün burç mesajı burada olacak.";
  late GenerativeModel model;

  @override
  void initState() {
    super.initState();
    // API anahtarınızı buraya girin veya uygun şekilde yönetin.
    const apiKey = 'YOUR_API_KEY_HERE';
    // gemini-2.0-flash modelini kullanıyoruz.
    model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
    _generateResponse();
  }

  Future<void> _generateResponse() async {
    try {
      final result = await model.generateText(
        prompt:
            "Generate a unique daily horoscope message with a mystical tone for my tarot app.",
      );
      setState(() {
        dailyMessage = result;
      });
    } catch (e) {
      setState(() {
        dailyMessage = "Error generating response: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            widget.imagePath,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.subtitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  dailyMessage,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on GenerativeModel {
  generateText({required String prompt}) {}
}

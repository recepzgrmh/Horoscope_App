import 'package:flutter/material.dart';

import 'package:flutter_gemini/flutter_gemini.dart';

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
  final gemini = Gemini.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateResponse();
  }

  Future<void> _generateResponse() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await gemini.text(
        "Tarot uygulamanız için mistik bir tonda benzersiz bir günlük burç mesajı oluşturun.",
      );
      setState(() {
        dailyMessage = response?.output ?? "Mesaj oluşturulamadı.";
      });
    } catch (e) {
      setState(() {
        dailyMessage = "Hata: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
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
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                // ListView ile sarmalıyoruz
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

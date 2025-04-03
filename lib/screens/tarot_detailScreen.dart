import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:horoscope/services/gemini_service.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/utils/zodiac_data.dart';

class TarotDetailScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String userId;
  final String zodiac;
  final String horoscopeType; // "daily", "weekly", or "monthly"

  const TarotDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.userId,
    required this.zodiac,
    required this.horoscopeType,
  });

  @override
  _TarotDetailScreenState createState() => _TarotDetailScreenState();
}

class _TarotDetailScreenState extends State<TarotDetailScreen> {
  bool _isLoading = false;
  Map<String, dynamic>? dailyData;

  @override
  void initState() {
    super.initState();
    _loadTarot();
  }

  Future<void> _loadTarot() async {
    setState(() => _isLoading = true);
    try {
      dailyData = await GeminiService.getTarotData(
        userId: widget.userId,
        horoscopeType: widget.horoscopeType,
      );
      if (dailyData == null) {
        await GeminiService.fetchAndSaveTarot(
          userId: widget.userId,
          zodiac: widget.zodiac,
          horoscopeType: widget.horoscopeType,
        );
        dailyData = await GeminiService.getTarotData(
          userId: widget.userId,
          horoscopeType: widget.horoscopeType,
        );
      }
    } catch (e) {
      debugPrint("Hata: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : dailyData == null
              ? const Center(child: Text("Horoscope verisi bulunamadı."))
              : SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top image with "Overview" overlay
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  widget.imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  color: Colors.black.withOpacity(0.5),
                                  child: const Text(
                                    'Overview',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Daily Message Section
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: MessageSection(
                            label: widget.horoscopeType,
                            message: dailyData?['dailyMessage'] ?? '',
                          ),
                        ),
                        // Mood Section
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: MoodSection(
                            label: widget.horoscopeType,
                            moodList: List<String>.from(
                              dailyData?['moodOfTheDay'] ?? [],
                            ),
                          ),
                        ),
                        // Overall Rating Section
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: OverallRatingSection(
                            overallRating: dailyData?['overallRating'] ?? 0.0,
                            ratingData: _parseRatingData(dailyData!),
                          ),
                        ),
                        // Comment Sections for Love, Career, Social
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: CommentSection(
                            titleText: 'Love',
                            subtitleText: dailyData?['love'] ?? '',
                          ),
                        ),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: CommentSection(
                            titleText: 'Career',
                            subtitleText: dailyData?['career'] ?? '',
                          ),
                        ),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: CommentSection(
                            titleText: 'Social',
                            subtitleText: dailyData?['social'] ?? '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }

  List<_RatingData> _parseRatingData(Map<String, dynamic> data) {
    if (data.containsKey('ratingDetails')) {
      final List<dynamic> list = data['ratingDetails'];
      return list
          .map(
            (item) => _RatingData(
              stars: item['stars'] as int,
              percent: item['percent'] as int,
            ),
          )
          .toList();
    }
    return [
      _RatingData(stars: 5, percent: 20),
      _RatingData(stars: 4, percent: 20),
      _RatingData(stars: 3, percent: 30),
      _RatingData(stars: 2, percent: 20),
      _RatingData(stars: 1, percent: 10),
    ];
  }
}

// New widget: MessageSection
class MessageSection extends StatelessWidget {
  final String message;
  final String label;
  const MessageSection({super.key, required this.message, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${label.capitalized} Message',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class CommentSection extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  const CommentSection({
    super.key,
    required this.titleText,
    required this.subtitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(subtitleText, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.thumb_up),
                color: AppColors.secondaryColor,
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.comment),
                color: AppColors.secondaryColor,
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
                color: AppColors.secondaryColor,
                iconSize: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MoodSection extends StatelessWidget {
  final String label;
  final List<String> moodList;
  const MoodSection({super.key, required this.moodList, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mood of the ${label.substring(0, label.length - 2).capitalized}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: moodList.map((mood) => _MoodWidget(mood)).toList(),
          ),
        ],
      ),
    );
  }
}

class _MoodWidget extends StatelessWidget {
  final String text;
  const _MoodWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class OverallRatingSection extends StatelessWidget {
  final double overallRating;
  final List<_RatingData> ratingData;
  const OverallRatingSection({
    super.key,
    required this.overallRating,
    required this.ratingData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Rating',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overallRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildStars(overallRating),
                  const SizedBox(height: 4),
                  Text(
                    '$overallRating stars',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      ratingData
                          .map((data) => _RatingBarRow(data: data))
                          .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStars(double rating) {
    final int fullStars = rating.floor();
    final bool hasHalfStar = (rating - fullStars) >= 0.5;
    List<Widget> stars = [];
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: AppColors.secondaryColor));
    }
    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: AppColors.secondaryColor));
    }
    while (stars.length < 5) {
      stars.add(Icon(Icons.star_border, color: AppColors.secondaryColor));
    }
    return Row(children: stars);
  }
}

class _RatingBarRow extends StatelessWidget {
  final _RatingData data;
  const _RatingBarRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            data.stars.toString(),
            style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: data.percent / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${data.percent}%',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _RatingData {
  final int stars;
  final int percent;
  _RatingData({required this.stars, required this.percent});
}

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:horoscope/styles/app_colors.dart';

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
  String dailyMessage =
      "Sevgili Gizem, bugün iletişim becerilerin ve yaratıcılığın oldukça güçlü. "
      "Yeni insanlarla tanışmak, fikir alışverişinde bulunmak ve sosyal ilişkilerini geliştirmek için harika bir gün. "
      "İlgi alanlarına yönelik farklı aktiviteler keşfedebilir, kısa geziler ya da spontane buluşmalarla kendini yenileyebilirsin. "
      "Duygusal anlamda ise içsel olarak güçlü ve kararlı hissedeceğin bir gündesin. "
      "Bugün isteklerin konusunda daha net adımlar atabilir, ilişkilerde belirsiz durumlara son verebilirsin. "
      "Kendine inanarak ilerlemen, çevrendeki insanların da seninle olan bağlarını güçlendirecek.";

  final gemini = Gemini.instance;
  final bool _isLoading = false;

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
                        // Üst görsel: imagePath ile dinamik resim kullanılıyor ve sol alt köşede "Overview" yazısı ekleniyor.
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
                        // Mood Bölümü
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const MoodSection(),
                          ),
                        ),
                        // Overall Rating Bölümü
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const OverallRatingSection(),
                          ),
                        ),
                        // Yorum Bölümleri
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const CommentSection(
                              titleText: 'Love',
                              subtitleText:
                                  "Harmony in love's realm today, sparking deeper connections. Communication fosters understanding. Embrace vulnerability for growth with your partner.",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const CommentSection(
                              titleText: 'Career',
                              subtitleText:
                                  "In career, adaptability is key. Embrace change and unexpected opportunities. Teamwork drives success.",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const CommentSection(
                              titleText: 'Social',
                              subtitleText:
                                  "Your social circle flourishes. New friendships could bloom or strengthen existing ties. Share your joy and listen actively.",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
  const MoodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mood of the Day',
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
            children: const [
              _MoodWidget('Optimistic'),
              _MoodWidget('Creative'),
              _MoodWidget('Romantic'),
              _MoodWidget('Energetic'),
            ],
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
  const OverallRatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double overallRating = 3.5;
    final List<_RatingData> ratingData = [
      _RatingData(stars: 5, percent: 20),
      _RatingData(stars: 4, percent: 20),
      _RatingData(stars: 3, percent: 30),
      _RatingData(stars: 2, percent: 20),
      _RatingData(stars: 1, percent: 10),
    ];

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
              // Genel puan ve yıldızlar
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
              // Her yıldız puanının barı
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

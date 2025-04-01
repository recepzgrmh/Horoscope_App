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
      "Sevgili Gizem, bugün iletişim becerilerin ve yaratıcılığın oldukça güçlü. Yeni insanlarla tanışmak, fikir alışverişinde bulunmak ve sosyal ilişkilerini geliştirmek için harika bir gün. İlgi alanlarına yönelik farklı aktiviteler keşfedebilir, kısa geziler ya da spontane buluşmalarla kendini yenileyebilirsin.Duygusal anlamda ise içsel olarak güçlü ve kararlı hissedeceğin bir gündesin. Bugün isteklerin konusunda daha net adımlar atabilir, ilişkilerde belirsiz durumlara son verebilirsin. Kendine inanarak ilerlemen, çevrendeki insanların da seninle olan bağlarını güçlendirecek.";
  final gemini = Gemini.instance;
  bool _isLoading = false;

  /*
  @override
  void initState() {
    super.initState();
    _generateResponse();
  }

  Future<void> _generateResponse() async {
    setState(() {
      _isLoading = true;
    });

    // Günün tarihini al ve formatla (örnek: 2024-03-23)
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final response = await gemini.text(
        "Bugün tarih: $currentDate. Kullanıcı için günlük tarot kartı okuması yap. "
        "Mistisizmi artır, ruhani bir mesaj ver. Astrolojik terimler kullanarak detaylı bir günlük yorum oluştur.",
      );

      setState(() {
        dailyMessage = response?.output ?? "Bugünün yorumu oluşturulamadı.";
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

  */

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
              : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.imagePath,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      dailyMessage,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';

String getDateFromZodiac(String zodiacName) {
  switch (zodiacName) {
    case 'Aries':
      return "Mart 21 - Nisan 19";
    case 'Taurus':
      return "Nisan 20 - Mayıs 20";
    case 'Gemini':
      return "Mayıs 21 - Haziran 20";
    case 'Cancer':
      return "Haziran 21 - Temmuz 22";
    case 'Leo':
      return "Temmuz 23 - Ağustos 22";
    case 'Virgo':
      return "Ağustos 23 - Eylül 22";
    case 'Libra':
      return "Eylül 23 - Ekim 22";
    case 'Scorpio':
      return "Ekim 23 - Kasım 21";
    case 'Sagittarius':
      return "Kasım 22 - Aralık 21";
    case 'Capricorn':
      return "Aralık 22 - Ocak 19";
    case 'Aquarius':
      return "Ocak 20 - Şubat 18";
    case 'Pisces':
      return "Şubat 19 - Mart 20";
    default:
      return "Bilinmeyen burç";
  }
}

String toCapitalize(String getString) {
  var firstLetter = getString.substring(0, 1);
  var rest = getString.substring(1);
  return firstLetter.toUpperCase() + rest;
}

class ZodiacDetailScreen2 extends StatefulWidget {
  final String zodiacName;
  final String imagePath;

  const ZodiacDetailScreen2({
    super.key,
    required this.zodiacName,
    required this.imagePath,
  });

  @override
  State<ZodiacDetailScreen2> createState() => _ZodiacDetailScreen2State();
}

class _ZodiacDetailScreen2State extends State<ZodiacDetailScreen2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      image: DecorationImage(
                        image: AssetImage(widget.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Transform.translate(
                      offset: const Offset(10, -20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            toCapitalize(widget.zodiacName),
                            style: TextStyle(
                              fontSize: 28,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            getDateFromZodiac(toCapitalize(widget.zodiacName)),
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              // TabBar kısmı
              TabBar(
                controller: _tabController,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textSecondary,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Compability'),
                  Tab(text: 'People'),
                ],
              ),
              // TabBarView kısmı
              SizedBox(
                height:
                    1200, // İçerik yüksekliğini ihtiyaçlarınıza göre ayarlayın
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'General Information',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Aquarius is the eleventh sign of the zodiac, symbolized by the Water Bearer and classified as an air sign. People born under Aquarius are known for their independent, innovative, and intellectually driven nature. They are forward-thinking visionaries who often embrace unconventional ideas and value freedom, equality, and social justice. Aquarians possess a strong humanitarian streak, always seeking to make the world a better place through unique perspectives and creative problem-solving.',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Famous Aquarius',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aqurais Compability',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Aquarius individuals typically enjoy a dynamic compatibility with fellow air signs like Gemini and Libra, who share their love for intellectual conversation and freedom. They also often click with fire signs such as Aries and Sagittarius, whose energy and passion complement Aquarius’ innovative nature. However, their strong need for independence might present challenges when paired with more emotionally grounded or possessive signs, making mutual respect and freedom the key to a thriving partnership.",
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Compability Chart',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            spacing: 20,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(Icons.favorite),
                                  Text('Gemini, Libra,  and Sagittarius.'),
                                ],
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(Icons.work),
                                  Text('Gemini, Libra, and Aries'),
                                ],
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(Icons.diversity_1_rounded),
                                  Text('Gemini, Libra, and Sagittarius'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(child: Text("People Content")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

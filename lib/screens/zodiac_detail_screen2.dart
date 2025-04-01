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
  if (getString.isEmpty) return getString;
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
      appBar: AppBar(title: Text(toCapitalize(widget.zodiacName))),
      body: SafeArea(
        child: Column(
          children: [
            // Üst bilgi kısmı
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
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
                  const SizedBox(width: 20),
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
                ],
              ),
            ),
            // TabBar
            TabBar(
              controller: _tabController,
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textSecondary,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Compatibility'),
                Tab(text: 'People'),
              ],
            ),
            // TabBarView: İçeriklerin her biri kendi kaydırılabilir alanına sahip
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Overview Tab (dinamik içerik örneği)
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'General Information about ${toCapitalize(widget.zodiacName)}',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // Burada dinamik veya ilgili veriyi gösterebilirsiniz
                          '${toCapitalize(widget.zodiacName)} burcu, genel olarak ... (bilgiler burada güncellenebilir)',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Famous ${toCapitalize(widget.zodiacName)}',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          // Eğer CarouselView özel bir widget ise ve tanımlıysa sorun yok.
                          // Aksi halde alternatif bir carousel widget veya PageView kullanabilirsiniz.
                          child: CarouselView(
                            itemExtent: 100,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                                child: Image.asset(
                                  'assets/images/zodiac-signs/virgo.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Compatibility Tab
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${toCapitalize(widget.zodiacName)} Compatibility',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${toCapitalize(widget.zodiacName)} individuals typically enjoy dynamic compatibility with fellow signs. (Detaylı bilgiler güncellenebilir.)',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Compatibility Chart',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.favorite),
                                SizedBox(width: 10),
                                Text('Gemini, Libra, and Sagittarius.'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: const [
                                Icon(Icons.work),
                                SizedBox(width: 10),
                                Text('Gemini, Libra, and Aries'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: const [
                                Icon(Icons.diversity_1_rounded),
                                SizedBox(width: 10),
                                Text('Gemini, Libra, and Sagittarius'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // People Tab
                  const Center(child: Text("People Content")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

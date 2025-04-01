import 'package:flutter/material.dart';
import 'package:horoscope/utils/zodiac_data.dart';
import 'package:horoscope/widgets/zodiac/zodiac_header.dart';
import 'package:horoscope/widgets/zodiac/zodiac_tabs.dart';

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
      appBar: AppBar(title: Text(widget.zodiacName.capitalized)),
      body: SafeArea(
        child: Column(
          children: [
            ZodiacHeader(
              zodiacName: widget.zodiacName,
              imagePath: widget.imagePath,
            ),
            // Burada ZodiacTabs widget'ını Expanded ile sarıyoruz:
            Expanded(
              child: ZodiacTabs(
                tabController: _tabController,
                zodiacName: widget.zodiacName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horoscope/screens/zodiac_detail_screen2.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:get/get.dart';

class ZodiacDetailScreen extends StatelessWidget {
  final String zodiacName;
  final String imagePath;

  const ZodiacDetailScreen({
    super.key,
    required this.zodiacName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(zodiacName.toUpperCase()), centerTitle: true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: screenHeight * 0.7,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, 0.8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${zodiacName.capitalize} burcu ile ilgili detaylı bilgi almak için ilerle",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  label: 'Devam Et',
                  onPressed:
                      () => Get.to(
                        ZodiacDetailScreen2(
                          zodiacName: zodiacName,
                          imagePath: imagePath,
                        ),
                      ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

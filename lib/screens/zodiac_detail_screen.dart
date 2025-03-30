import 'package:flutter/material.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:horoscope/styles/app_colors.dart';

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
              // 📌 **Burç Resmi (İçeriği Yukarı Kaydırılmış)**
              Container(
                height: screenHeight * 0.7, // 📌 **Ekranın %50'sini kaplasın**
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit:
                        BoxFit
                            .cover, // ✅ **Resmin içeriğini kaplayacak şekilde ölçekler**
                    alignment: Alignment(
                      0,
                      0.8,
                    ), // ✅ **İçeriği yukarı kaydırır**
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 📌 **Burç Açıklaması**
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Burç açıklamaları burada olacak. Burcun tarihi, özellikleri ve yorumları ekleyebilirsin.",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              // 📌 **Geri Dön Butonu**
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  label: 'Geri Dön',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: AppColors.primaryColor,
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

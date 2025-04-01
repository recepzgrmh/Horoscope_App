import 'package:flutter/material.dart';
import 'package:horoscope/opening.dart';
import 'package:horoscope/screens/animated_home_screen.dart';
import 'package:horoscope/services/firebase_services.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:get/get.dart';

class VerifyAccount extends StatefulWidget {
  const VerifyAccount({super.key});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  Future<void> verifyAccount() async {
    try {
      await FirebaseServices.sendVerificationEmail();
      Get.snackbar(
        "Email Gönderildi",
        "Lütfen e-posta kutunuzu kontrol edin.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Hata", "$e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> checkVerification() async {
    try {
      bool verified = await FirebaseServices.checkEmailVerification();
      if (verified) {
        Get.offAll(() => AnimatedHomeScreen());
      } else {
        Get.snackbar(
          "Hesap Doğrulanmadı",
          "Lütfen e-posta kutunuzu kontrol edin ve doğrulama linkine tıklayın.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Hata", "$e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offAll(() => const Opening()),
          icon: const Icon(Icons.arrow_back),
        ),
        toolbarHeight: 100,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.email_outlined,
                  size: 100,
                  color: AppColors.accentColor,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Lütfen mailinize gelen doğrulama linkine tıklayın",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.primaryColor),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: "Devam Et",
                  onPressed: checkVerification,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Doğrulama maili ulaşmadı mı?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  isPrimary: false,
                  label: "Tekrar Gönder",
                  onPressed: verifyAccount,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/opening.dart';
import 'package:horoscope/screens/home_screen.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerifyAccount extends StatefulWidget {
  const VerifyAccount({super.key});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  // Mevcut kullanıcıya doğrulama emaili gönderir
  Future<void> verifyAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      Get.snackbar(
        "Email Gönderildi",
        "Lütfen e-posta kutunuzu kontrol edin.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Hata",
        "Kullanıcı bulunamadı veya email zaten doğrulanmış.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Kullanıcının e-posta doğrulama durumunu kontrol eder ve tüm bilgileri kaydeder
  Future<void> checkVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        final docRef = FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid);
        final docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          final userData = docSnapshot.data() as Map<String, dynamic>?;

          await docRef.set({
            "verifiedAt": FieldValue.serverTimestamp(),
            "birthDate": userData?["birthDate"] ?? "",
            "gender":
                userData?["gender"] ??
                "", // `gender` bilgisi eksikse tamamlanıyor ✅
            "zodiacSign": userData?["zodiacSign"] ?? "",
          }, SetOptions(merge: true));
        }

        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar(
          "Hesap Doğrulanmadı",
          "Lütfen e-posta kutunuzu kontrol edin ve doğrulama linkine tıklayın.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar: Geri tuşu Get.offAll ile çalışıyor
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

              // "Devam Et" butonu
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: "Devam Et",
                  onPressed: checkVerification,
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Doğrulama maili ulaşmadı mı?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 15),

              // "Tekrar Gönder" butonu
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: "Tekrar Gönder",
                  onPressed: verifyAccount,
                  backgroundColor: AppColors.deactiveButton,
                  foregroundColor: AppColors.primaryColor,
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

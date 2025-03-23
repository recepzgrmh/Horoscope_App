import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/opening.dart';
import 'package:horoscope/screens/home_screen.dart';
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

  // Kullanıcının e-posta doğrulama durumunu kontrol eder
  Future<void> checkVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload(); // Kullanıcı verilerini güncelleyin
      if (user.emailVerified) {
        final docSnapshot =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .get();
        if (!docSnapshot.exists) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set({
                "displayName": user.displayName,
                "email": user.email,
                "verifiedAt": DateTime.now(),
              });
        }
        // Doğrulama başarılı, anasayfaya yönlendir
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
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Lütfen mailinize gelen doğrulama linkine tıklayın",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(height: 30),

              // "Devam Et" butonu
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: "Devam Et",
                  onPressed: checkVerification,
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  verticalPadding: 16,
                  minHeight: 48,
                  elevation: 5,
                  borderRadius: BorderRadius.zero,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Doğrulama maili ulaşmadı mı?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 15),

              // "Tekrar Gönder" butonu
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: "Tekrar Gönder",
                  onPressed: verifyAccount,
                  backgroundColor: const Color(0xFFE8EEF2),
                  foregroundColor: Colors.black,
                  verticalPadding: 16,
                  minHeight: 48,
                  elevation: 5,
                  borderRadius: BorderRadius.zero,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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

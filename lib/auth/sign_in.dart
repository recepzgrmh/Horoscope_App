import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/auth/reset_password.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:horoscope/widgets/text_inputs.dart';
import 'package:horoscope/wrapper.dart';
import 'package:get/get.dart';
import 'sign_up_step1.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // Giriş yapma fonksiyonu
  Future<void> signInUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email.text.trim(),
            password: password.text.trim(),
          );

      User? user = userCredential.user;

      if (user != null) {
        print("🔥 Kullanıcı giriş yaptı: \${user.email}");
        print("📌 Kullanıcı UID: \${user.uid}");

        // Ana ekrana yönlendir
        Get.offAll(() => const Wrapper());
      }
    } catch (e) {
      print("🚨 Firebase Giriş Hatası: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Giriş yapılamadı: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Klavye açıldığında taşma olmaması için
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Textleri sola hizalar
            children: [
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Tekrar Hoşgeldin!',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Devam etmek için gerekli yerleri doldurun.',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 40),
              TextInputs(labelText: 'E-mail', controller: email, isEmail: true),
              SizedBox(height: 20),
              TextInputs(
                labelText: 'Şifre',
                controller: password,
                isPassword: true,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Devam ederek Kullanım Şartları'nı kabul etmiş olursunuz.\nGizlilik Politikamızı okuyun.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                label: "Giriş Yap",
                onPressed: signInUser,
                backgroundColor: AppColors.accentColor,
                foregroundColor: Colors.white,
              ),
              const SizedBox(height: 20),
              CustomButton(
                label: "Şifremi Unuttum",
                onPressed: () => Get.to(const ResetPassword()),
                backgroundColor: AppColors.deactiveButton,
                foregroundColor: AppColors.primaryColor,
              ),
              const SizedBox(height: 10),
              CustomButton(
                label: "Şimdi Hesap Oluştur",
                onPressed: () => Get.to(const SignUpStep1()),
                backgroundColor: AppColors.deactiveButton,
                foregroundColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

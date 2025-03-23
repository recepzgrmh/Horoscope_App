import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/auth/reset_password.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:horoscope/widgets/text_inputs.dart';
import 'package:horoscope/wrapper.dart';
import 'package:get/get.dart';
import 'sign_up.dart';

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
        print("🔥 Kullanıcı giriş yaptı: ${user.email}");
        print("📌 Kullanıcı UID: ${user.uid}");

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
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Tekrar Hoşgeldin!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Devam etmek için gerekli yerleri doldurun.",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 40),
              TextInputs(labelText: 'E-mail', controller: email, isEmail: true),
              const SizedBox(height: 20),
              TextInputs(
                labelText: 'Şifre',
                controller: password,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              Text(
                "Devam ederek Kullanım Şartları'nı kabul etmiş olursunuz.\nGizlilik Politikamızı okuyun.",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 30),

              // "Giriş Yap" butonu
              CustomButton(
                label: "Giriş Yap",
                onPressed: signInUser,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                verticalPadding: 16,
                minHeight: 48,
                elevation: 3,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),

              // "Şifremi Unuttum" butonu
              CustomButton(
                label: "Şifremi Unuttum",
                onPressed: () => Get.to(const ResetPassword()),
                backgroundColor: Color(0xFFE8EEF2),
                foregroundColor: Colors.black,
                verticalPadding: 16,
                minHeight: 48,
                elevation:
                    0, // Orijinal kodda yoktu, isterseniz 3 de yapabilirsiniz
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),

              // "Şimdi Hesap Oluştur" butonu
              CustomButton(
                label: "Şimdi Hesap Oluştur",
                onPressed: () => Get.to(const SignUp()),
                backgroundColor: Color(0xFFE8EEF2),
                foregroundColor: Colors.black,
                verticalPadding: 16,
                minHeight: 48,
                elevation: 0,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

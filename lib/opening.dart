import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'auth/sign_in.dart';
import 'auth/sign_up_step1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase başlatma için gerekli
  await Firebase.initializeApp(); // Firebase'i sadece bir kez başlat
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: Opening());
  }
}

class Opening extends StatelessWidget {
  const Opening({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: Image.asset(
              'assets/images/real-opening.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Welcome to the\n Mystical Sky',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Text(
            "Your personal guide for the future. We use\n astrology and tarot to help you navigate life's\n ups and downs.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Sign Up',
                    onPressed: () => Get.to(SignUpStep1()),
                  ),
                ),
                SizedBox(width: 10), // Butonlar arasında boşluk
                Expanded(
                  child: CustomButton(
                    isPrimary: false,
                    label: 'Log in',
                    onPressed: () => Get.to(SignIn()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

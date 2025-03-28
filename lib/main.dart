import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'firebase_options.dart';
import 'package:horoscope/wrapper.dart';
import 'package:get/get.dart';
import 'package:horoscope/styles/app_theme.dart'; // Temayı dahil ettik

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  try {
    await _initializeFirebase();
  } catch (e) {
    print("🔥 Firebase Hatası: $e");
  }

  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY'] ?? '');

  runApp(const MyApp());
}

Future<void> _initializeFirebase() async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme, // Tema burada aktif
      home: const Wrapper(),
    );
  }
}

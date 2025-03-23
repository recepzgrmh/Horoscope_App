import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'firebase_options.dart';
import 'package:horoscope/wrapper.dart';
import 'package:horoscope/styles/app_theme.dart';
import 'package:get/get.dart'; // ✅ GetX paketini unutma!

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  try {
    await _initializeFirebase(); // ✅ Firebase başlatmayı tek fonksiyon içine aldık
  } catch (e) {
    print("🔥 Firebase Hatası: $e");
  }

  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY'] ?? '');

  runApp(const MyApp());
}

// ✅ Firebase başlatmayı kesinlikle tek seferlik yapan fonksiyon
Future<void> _initializeFirebase() async {
  if (Firebase.apps.isEmpty) {
    // ✅ Firebase zaten başlatılmış mı kontrol et
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
      // ✅ GetMaterialApp kullanmalısın!
      debugShowCheckedModeBanner: false,
      home: const Wrapper(),
      theme: AppTheme.theme,
    );
  }
}

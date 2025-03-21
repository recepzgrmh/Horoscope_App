import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:horoscope/screens/home_screen.dart';
import 'package:horoscope/styles/app_theme.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Proje kök dizininde bulunan .env dosyasını yüklemeye çalışıyoruz
  try {
    await dotenv.load(fileName: ".env");
    print("✅ .env dosyası başarıyla yüklendi.");
  } catch (e) {
    print("❌ .env dosyası bulunamadı veya yüklenemedi. Hata: $e");
  }

  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY'] ?? '');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: AppTheme.theme,
    );
  }
}

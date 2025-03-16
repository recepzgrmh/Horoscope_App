import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:horoscope/screens/homeScreen.dart';
import 'package:horoscope/styles/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Proje kök dizininde bulunan .env dosyasını yüklemeye çalışıyoruz
  try {
    await dotenv.load(fileName: ".env");
    print("✅ .env dosyası başarıyla yüklendi.");
  } catch (e) {
    print("❌ .env dosyası bulunamadı veya yüklenemedi. Hata: $e");
  }

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

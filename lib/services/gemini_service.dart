import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static final Gemini _gemini = Gemini.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Belirtilen kullanıcının burcuna ve tarihe göre Gemini API'sinden verileri çeker,
  /// ardından Firestore'a kaydeder.
  static Future<void> fetchAndSaveDailyTarot({
    required String userId,
    required String zodiac,
  }) async {
    final String currentDate = DateTime.now().toIso8601String().substring(
      0,
      10,
    );
    final String docId = '$userId-$currentDate';

    // Eğer veri zaten varsa, tekrar çekmeye gerek yok.
    final docSnapshot =
        await _firestore.collection('dailyTarot').doc(docId).get();
    if (docSnapshot.exists) return;

    final String prompt = '''
Bugün tarih: $currentDate.
Kullanıcının burcu: $zodiac.
Lütfen aşağıdaki alanlarda detaylı günlük yorum oluştur:
- dailyMessage: Genel günlük yorum.
- moodOfTheDay: Kullanıcının sahip olabileceği 2-3 mood.
- overallRating: Bu gün için 1 ile 5 arasında bir puan.
- love: Aşk alanı yorumu.
- career: Kariyer alanı yorumu.
- social: Sosyal yaşam yorumu.
Lütfen cevapları JSON formatında ver.
''';

    try {
      final response = await _gemini.text(prompt);
      String rawOutput = response?.output?.trim() ?? '';

      // Log raw output for debugging
      print("Gemini API raw output: $rawOutput");

      // Eğer ham çıktı ```json ile başlıyorsa temizleyelim.
      if (rawOutput.startsWith("```json")) {
        rawOutput = rawOutput.replaceFirst("```json", "").trim();
      }
      if (rawOutput.endsWith("```")) {
        rawOutput = rawOutput.substring(0, rawOutput.length - 3).trim();
      }

      // Eğer temizlenmiş çıktı hala geçerli bir JSON değilse hata fırlatın.
      if (rawOutput.isEmpty || !rawOutput.startsWith('{')) {
        throw Exception("Gemini API geçerli JSON döndürmüyor: $rawOutput");
      }

      final Map<String, dynamic> result = jsonDecode(rawOutput);

      await _firestore.collection('dailyTarot').doc(docId).set({
        'userId': userId,
        'date': currentDate,
        'zodiac': zodiac,
        'dailyMessage': result['dailyMessage'] ?? '',
        'moodOfTheDay': result['moodOfTheDay'] ?? [],
        'overallRating':
            (result['overallRating'] is num)
                ? (result['overallRating'] as num).toDouble()
                : 0.0,
        'love': result['love'] ?? '',
        'career': result['career'] ?? '',
        'social': result['social'] ?? '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Gemini API çağrısı veya veri kaydı sırasında hata: $e");
    }
  }

  /// Firestore'dan bugüne ait veriyi getirir.
  static Future<Map<String, dynamic>?> getDailyTarotData({
    required String userId,
  }) async {
    final String currentDate = DateTime.now().toIso8601String().substring(
      0,
      10,
    );
    final String docId = '$userId-$currentDate';
    final docSnapshot =
        await _firestore.collection('dailyTarot').doc(docId).get();
    return docSnapshot.exists ? docSnapshot.data() : null;
  }
}

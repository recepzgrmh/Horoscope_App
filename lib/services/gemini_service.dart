import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

/// Horoscope türüne bağlı olarak uygun tarih periyodunu oluşturur.
/// - daily: "YYYY-MM-DD"
/// - weekly: Haftanın başı (örneğin Pazartesi tarihini)
/// - monthly: "YYYY-MM"
String getPeriodString(String horoscopeType) {
  final DateTime now = DateTime.now();
  switch (horoscopeType.toLowerCase()) {
    case 'daily':
      return now.toIso8601String().substring(0, 10);
    case 'weekly':
      // Haftalık: Haftanın başlangıcı (Pazartesi)
      final int daysFromMonday = now.weekday - 1; // Monday = 1
      final DateTime monday = now.subtract(Duration(days: daysFromMonday));
      return monday.toIso8601String().substring(0, 10);
    case 'monthly':
      return '${now.year}-${now.month.toString().padLeft(2, '0')}';
    default:
      return now.toIso8601String().substring(0, 10);
  }
}

class GeminiService {
  static final Gemini _gemini = Gemini.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Gemini API'den veri çekip, Firestore'a kaydeder.
  /// Doküman ID'si: "$userId-$horoscopeType-$period"
  /// Yeni veri eklenirken, aynı kullanıcı ve horoscopeType için
  /// farklı dönemlere ait dokümanlar silinir.
  static Future<void> fetchAndSaveTarot({
    required String userId,
    required String zodiac,
    required String horoscopeType, // "daily", "weekly", or "monthly"
  }) async {
    final String period = getPeriodString(horoscopeType);
    final String docId = '$userId-$horoscopeType-$period';

    // İlgili dönem için belge zaten varsa, yeniden API çağrısı yapmadan çık.
    final docSnapshot =
        await _firestore.collection('tarotHoroscope').doc(docId).get();
    if (docSnapshot.exists) return;

    // Gemini'ye gönderilen prompt artık horoscopeType'e göre genel yorum yapması için "generalMessage" kullanıyor.
    final String prompt = '''
Bugün tarih: $period.
Kullanıcının burcu: $zodiac.
Horoscope Type: $horoscopeType.
Lütfen aşağıdaki alanlarda detaylı yorum oluştur:
- generalMessage: ${horoscopeType[0].toUpperCase()}${horoscopeType.substring(1)} yorum.
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

      // Hata ayıklama amacıyla ham çıktıyı loglama
      print("Gemini API raw output: $rawOutput");

      // Çıktı markdown formatında ise temizle
      if (rawOutput.startsWith("```json")) {
        rawOutput = rawOutput.replaceFirst("```json", "").trim();
      }
      if (rawOutput.endsWith("```")) {
        rawOutput = rawOutput.substring(0, rawOutput.length - 3).trim();
      }

      if (rawOutput.isEmpty || !rawOutput.startsWith('{')) {
        throw Exception("Gemini API geçerli JSON döndürmüyor: $rawOutput");
      }

      final Map<String, dynamic> result = jsonDecode(rawOutput);

      // Yeni veriyi Firestore'a kaydet (alan adı generalMessage olarak güncellendi)
      await _firestore.collection('tarotHoroscope').doc(docId).set({
        'userId': userId,
        'period': period,
        'horoscopeType': horoscopeType,
        'zodiac': zodiac,
        'generalMessage': result['generalMessage'] ?? '',
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

      // Aynı kullanıcı ve horoscopeType için eski (farklı dönem) dokümanları sil
      final QuerySnapshot snapshot =
          await _firestore
              .collection('tarotHoroscope')
              .where('userId', isEqualTo: userId)
              .where('horoscopeType', isEqualTo: horoscopeType)
              .get();

      for (var doc in snapshot.docs) {
        final docData = doc.data() as Map<String, dynamic>;
        if (docData['period'] != period) {
          await doc.reference.delete();
        }
      }
    } catch (e) {
      throw Exception("Gemini API çağrısı veya veri kaydı sırasında hata: $e");
    }
  }

  /// Verilen kullanıcı ve horoscopeType için geçerli dönem dokümanını getirir.
  static Future<Map<String, dynamic>?> getTarotData({
    required String userId,
    required String horoscopeType,
  }) async {
    final String period = getPeriodString(horoscopeType);
    final String docId = '$userId-$horoscopeType-$period';
    final docSnapshot =
        await _firestore.collection('tarotHoroscope').doc(docId).get();
    return docSnapshot.exists ? docSnapshot.data() : null;
  }
}

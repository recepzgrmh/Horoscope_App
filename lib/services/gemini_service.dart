import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static final Gemini _gemini = Gemini.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches data from the Gemini API and saves it into Firestore under a document whose ID is:
  /// "$userId-$horoscopeType-$currentDate".
  /// After saving the new document, old entries (with the same user and horoscope type, but a different date)
  /// are deleted.
  static Future<void> fetchAndSaveTarot({
    required String userId,
    required String zodiac,
    required String horoscopeType, // "daily", "weekly", or "monthly"
  }) async {
    final String currentDate = DateTime.now().toIso8601String().substring(
      0,
      10,
    );
    final String docId = '$userId-$horoscopeType-$currentDate';

    // Check if today's document for this horoscope type already exists.
    final docSnapshot =
        await _firestore.collection('tarotHoroscope').doc(docId).get();
    if (docSnapshot.exists) return;

    final String prompt = '''
Bugün tarih: $currentDate.
Kullanıcının burcu: $zodiac.
Horoscope Type: $horoscopeType.
Lütfen aşağıdaki alanlarda detaylı yorum oluştur:
- dailyMessage: Genel yorum.
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

      // Clean the raw output if it starts/ends with markdown formatting.
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

      // Save new data into Firestore
      await _firestore.collection('tarotHoroscope').doc(docId).set({
        'userId': userId,
        'date': currentDate,
        'horoscopeType': horoscopeType,
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

      // Delete any old documents for this user and horoscopeType that are not for today.
      final QuerySnapshot snapshot =
          await _firestore
              .collection('tarotHoroscope')
              .where('userId', isEqualTo: userId)
              .where('horoscopeType', isEqualTo: horoscopeType)
              .get();

      for (var doc in snapshot.docs) {
        if ((doc.data() as Map<String, dynamic>)['date'] != currentDate) {
          await doc.reference.delete();
        }
      }
    } catch (e) {
      throw Exception("Gemini API çağrısı veya veri kaydı sırasında hata: $e");
    }
  }

  /// Retrieves the horoscope document for today for a given user.
  static Future<Map<String, dynamic>?> getTarotData({
    required String userId,
    required String horoscopeType,
  }) async {
    final String currentDate = DateTime.now().toIso8601String().substring(
      0,
      10,
    );
    final String docId = '$userId-$horoscopeType-$currentDate';
    final docSnapshot =
        await _firestore.collection('tarotHoroscope').doc(docId).get();
    return docSnapshot.exists ? docSnapshot.data() : null;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/opening.dart';
import '../utils/date_utils.dart' as my_utils;

class UserService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> getUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data();

      if (data != null && data["birthDate"] != null) {
        final age = my_utils.DateUtils.calculateAge(data["birthDate"]);

        data["age"] = age.toString();

        await _firestore.collection('users').doc(user.uid).update({
          'age': age.toString(),
        });
      }
      return data;
    }
    return null;
  }

  /// 🔹 Kullanıcı çıkış yapar ve giriş ekranına yönlendirilir
  static Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      // 🔹 Konsola log bas (çıkış işlemi başarılı mı kontrol etmek için)
      debugPrint("Çıkış işlemi başarıyla tamamlandı, navigation yapılıyor!");

      // 🔹 Navigasyonu düzgün çalıştırmak için `WidgetsBinding.instance.addPostFrameCallback` kullan
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => Opening()),
          (route) => false,
        );
      });
    } catch (e) {
      debugPrint("Çıkış sırasında hata oluştu: $e");
    }
  }
}

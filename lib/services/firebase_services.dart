import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../utils/date_utils.dart' as my_utils;
import 'package:flutter/material.dart';
import 'package:horoscope/opening.dart';

class FirebaseServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Kullanıcı giriş işlemi
  static Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      return Future.error("Giriş başarısız: $e");
    }
  }

  /// Kullanıcı kaydı (signup)
  static Future<User?> signUp({
    required UserModel user,
    required String birthDate,
    required String? zodiacSign,
  }) async {
    if (birthDate.isEmpty || zodiacSign == null || zodiacSign.isEmpty) {
      return Future.error("Lütfen doğum tarihinizi ve burcunuzu girin.");
    }
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );

      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(
          "${user.fullName} ${user.lastName}",
        );
        await firebaseUser.sendEmailVerification();

        await _firestore.collection("users").doc(firebaseUser.uid).set({
          "fullName": user.fullName,
          "lastName": user.lastName,
          "email": user.email,
          "birthDate": birthDate.trim(),
          "gender": user.gender,
          "zodiacSign": zodiacSign,
          "verifiedAt": null,
        });
        return firebaseUser;
      } else {
        return Future.error("Kayıt başarısız, kullanıcı bulunamadı.");
      }
    } catch (e) {
      return Future.error("Kayıt sırasında hata oluştu: $e");
    }
  }

  /// Şifre sıfırlama işlemi
  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      return Future.error("Şifre sıfırlama başarısız: $e");
    }
  }

  /// Çıkış yapma işlemi
  static Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const Opening()),
          (route) => false,
        );
      });
    } catch (e) {
      debugPrint("Çıkış sırasında hata oluştu: $e");
    }
  }

  /// E-posta doğrulama gönderme
  static Future<void> sendVerificationEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    } else {
      return Future.error(
        "Kullanıcı bulunamadı veya e-posta zaten doğrulandı.",
      );
    }
  }

  /// E-posta doğrulama durumunu kontrol etme
  static Future<bool> checkEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        // Firestore'daki kullanıcı verisini güncelle
        final docRef = _firestore.collection("users").doc(user.uid);
        final docSnapshot = await docRef.get();
        if (docSnapshot.exists) {
          final userData = docSnapshot.data();
          await docRef.set({
            "verifiedAt": FieldValue.serverTimestamp(),
            "birthDate": userData?["birthDate"] ?? "",
            "gender": userData?["gender"] ?? "",
            "zodiacSign": userData?["zodiacSign"] ?? "",
          }, SetOptions(merge: true));
        }
        return true;
      }
    }
    return false;
  }

  /// Kullanıcı bilgilerini Firestore'dan çekme
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
}

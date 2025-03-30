import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Giriş yapma işlemini gerçekleştiren metot.
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
      return Future.error(e);
    }
  }

  /// Şifre sıfırlama işlemini gerçekleştiren metot.
  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Kullanıcı kayıt işlemini gerçekleştiren metot.
  /// [user]: Kullanıcının temel bilgileri.
  /// [birthDate]: Doğum tarihi.
  /// [zodiacSign]: Seçilen burç.
  static Future<User?> signUp({
    required UserModel user,
    required String birthDate,
    required String? zodiacSign,
  }) async {
    if (birthDate.isEmpty && (zodiacSign == null || zodiacSign.isEmpty)) {
      return Future.error("Lütfen doğum tarihinizi veya burcunuzu seçin.");
    }
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Firebase kullanıcı profilini güncelle
        await firebaseUser.updateDisplayName(
          "${user.fullName} ${user.lastName}",
        );
        await firebaseUser.reload();

        // Doğrulama e-postası gönder
        await firebaseUser.sendEmailVerification();

        // Kullanıcı bilgilerini Firestore'a kaydet
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
      return Future.error(e);
    }
  }

  /// Çıkış yapma işlemini gerçekleştiren metot.
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Doğrulama e-postası gönderme.
  static Future<void> sendVerificationEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    } else {
      return Future.error("Kullanıcı bulunamadı veya email zaten doğrulanmış.");
    }
  }

  /// E-posta doğrulama kontrolü yapar.
  /// Doğrulama başarılı ise kullanıcı verilerini günceller.
  static Future<bool> checkEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
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
}

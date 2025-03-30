import 'package:flutter/material.dart';
import 'package:horoscope/auth/sign_in.dart';
import 'package:horoscope/services/auth_services.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:horoscope/widgets/text_inputs.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();

  Future<void> resetPassword() async {
    try {
      await AuthService.resetPassword(email: email.text);
      Get.snackbar(
        "Link Gönderildi",
        "Reset link sent!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.cardColor,
        colorText: AppColors.primaryColor,
      );
      // 3 saniye bekledikten sonra, SignIn ekranına fadeIn animasyonu ile geçiş yap.
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(
          () => const SignIn(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      });
    } catch (e) {
      Get.snackbar(
        "Link Gönderilemedi",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.cardColor,
        colorText: AppColors.primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Şifreni mi Unuttun?',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Hesabınızla ilişkili e-posta adresini girin, size şifrenizi sıfırlamanız için bir bağlantı gönderelim.',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 40),
              TextInputs(labelText: 'E-mail', controller: email, isEmail: true),
              const SizedBox(height: 30),
              CustomButton(
                label: "Şifre Sıfırlama Linki Gönder",
                onPressed: resetPassword,
                backgroundColor: AppColors.accentColor,
                foregroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

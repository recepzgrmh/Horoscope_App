import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horoscope/services/auth_services.dart';
import 'package:horoscope/styles/app_colors.dart';
import '../widgets/auth_forms.dart';
import '../widgets/auth_text_inputs.dart';
import '../widgets/auth_buttons.dart';
import 'reset_password.dart';
import 'sign_up_step1.dart';
import '../wrapper.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signInUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await AuthService.signIn(
          email: email.text,
          password: password.text,
        );
        if (user != null) {
          Get.offAll(() => const Wrapper());
        }
      } catch (e) {
        Get.snackbar(
          "Giriş Yapılamadı",
          "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.cardColor,
          colorText: AppColors.primaryColor,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: AuthForm(
          title: 'Tekrar Hoşgeldin!',
          subtitle: 'Devam etmek için gerekli yerleri doldurun.',
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextInput(
                    labelText: 'E-mail',
                    controller: email,
                    isEmail: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen email giriniz';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Geçerli bir email giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthTextInput(
                    labelText: 'Şifre',
                    controller: password,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen şifre giriniz';
                      }
                      if (value.length < 6) {
                        return 'Şifre en az 6 karakter olmalı';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            AuthButton(label: "Giriş Yap", onPressed: signInUser),
            const SizedBox(height: 20),
            AuthButton(
              label: "Şifremi Unuttum",
              onPressed: () => Get.to(const ResetPassword()),
              isPrimary: false,
            ),
            const SizedBox(height: 10),
            AuthButton(
              label: "Şimdi Hesap Oluştur",
              onPressed: () => Get.to(const SignUpStep1()),
              isPrimary: false,
            ),
          ],
        ),
      ),
    );
  }
}

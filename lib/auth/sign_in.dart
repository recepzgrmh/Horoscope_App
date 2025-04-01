import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horoscope/services/firebase_services.dart';

import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/auth/auth_forms.dart';
import 'package:horoscope/widgets/auth/auth_text_inputs.dart';
import 'package:horoscope/widgets/custom_button.dart';

import 'package:horoscope/widgets/loading_overlay.dart';
import 'package:horoscope/wrapper.dart';
import 'reset_password.dart';
import 'sign_up_step1.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;

  Future<void> signInUser() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try {
      final user = await FirebaseServices.signIn(
        email: email.text,
        password: password.text,
      );
      if (user != null) {
        Get.offAll(
          () => const Wrapper(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Giriş Hatası",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.cardColor,
        colorText: AppColors.primaryColor,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
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
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SafeArea(
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
              CustomButton(label: "Giriş Yap", onPressed: signInUser),
              const SizedBox(height: 20),
              CustomButton(
                label: "Şifremi Unuttum",
                onPressed: () => Get.to(const ResetPassword()),
                isPrimary: false,
              ),
              const SizedBox(height: 10),
              CustomButton(
                label: "Şimdi Hesap Oluştur",
                onPressed: () => Get.to(const SignUpStep1()),
                isPrimary: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

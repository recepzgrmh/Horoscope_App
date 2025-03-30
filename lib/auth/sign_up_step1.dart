import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../widgets/auth_forms.dart';
import '../widgets/auth_text_inputs.dart';
import '../widgets/auth_buttons.dart';
import 'sign_up_step2.dart';

class SignUpStep1 extends StatefulWidget {
  const SignUpStep1({super.key});

  @override
  State<SignUpStep1> createState() => _SignUpStep1State();
}

class _SignUpStep1State extends State<SignUpStep1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  String? gender;

  void nextStep() {
    if (_formKey.currentState!.validate()) {
      UserModel user = UserModel(
        fullName: fullName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
        gender: gender!,
      );

      Get.to(() => SignUpStep2(user: user));
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
          title: 'Hesap Oluştur',
          subtitle: 'Başlamak için kayıt olun!',
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextInput(
                    labelText: 'Ad',
                    controller: fullName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen adınızı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthTextInput(
                    labelText: 'Soyad',
                    controller: lastName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen soyadınızı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      labelText: "Cinsiyet Seçiniz",
                    ),
                    value: gender,
                    items:
                        ["Erkek", "Kadın", "Diğer"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        gender = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen cinsiyet seçiniz';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            AuthButton(label: "İleri", onPressed: nextStep),
          ],
        ),
      ),
    );
  }
}

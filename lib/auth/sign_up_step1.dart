import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/auth/sign_up_step2.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:horoscope/widgets/text_inputs.dart';
import 'package:get/get.dart';
import 'package:horoscope/models/user_model.dart';

class SignUpStep1 extends StatefulWidget {
  const SignUpStep1({super.key});

  @override
  State<SignUpStep1> createState() => _SignUpStep1State();
}

class _SignUpStep1State extends State<SignUpStep1> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Hesap Oluştur',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 6),
              Text(
                'Başlamak İçin Kayıt Olun!',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 40),
              TextInputs(labelText: 'Ad', controller: fullName),
              SizedBox(height: 20),
              TextInputs(labelText: 'SoyAd', controller: lastName),
              SizedBox(height: 20),
              TextInputs(labelText: 'E-mail', controller: email, isEmail: true),
              SizedBox(height: 20),
              TextInputs(
                labelText: 'Şifre',
                controller: password,
                isPassword: true,
              ),
              SizedBox(height: 20),
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
              ),
              SizedBox(height: 20),
              Text(
                "Devam ederek Kullanım Şartları'nı kabul etmiş olursunuz.\nGizlilik Politikamızı okuyun.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 30),
              CustomButton(
                label: "İleri",
                onPressed: () {
                  if (fullName.text.trim().isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("İsim boş olamaz.")));
                    return;
                  }

                  if (lastName.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Soyisim boş olamaz.")),
                    );
                    return;
                  }

                  if (email.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("E-mail boş olamaz.")),
                    );
                    return;
                  }

                  if (password.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Şifre boş olamaz.")),
                    );
                    return;
                  }

                  if (gender == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Lütfen cinsiyetinizi seçiniz.")),
                    );
                    return;
                  }

                  UserModel user = UserModel(
                    fullName: fullName.text.trim(),
                    lastName: lastName.text.trim(),
                    email: email.text.trim(),
                    password: password.text.trim(),
                    gender: gender!,
                  );

                  Get.to(() => SignUpStep2(user: user));
                },
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

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
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  String? gender;

  void nextStep() {
    if (fullName.text.trim().isEmpty ||
        lastName.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        password.text.trim().isEmpty ||
        gender == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Lütfen tüm alanları doldurun.")));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 80, leading: BackButton()),
      body: SafeArea(
        child: AuthForm(
          title: 'Hesap Oluştur',
          subtitle: 'Başlamak için kayıt olun!',
          children: [
            AuthTextInput(labelText: 'Ad', controller: fullName),
            const SizedBox(height: 20),
            AuthTextInput(labelText: 'Soyad', controller: lastName),
            const SizedBox(height: 20),
            AuthTextInput(
              labelText: 'E-mail',
              controller: email,
              isEmail: true,
            ),
            const SizedBox(height: 20),
            AuthTextInput(
              labelText: 'Şifre',
              controller: password,
              isPassword: true,
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
            ),
            const SizedBox(height: 30),
            AuthButton(label: "İleri", onPressed: nextStep),
          ],
        ),
      ),
    );
  }
}

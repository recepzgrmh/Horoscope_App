import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:horoscope/widgets/text_inputs.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Reset link sent!")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Klavye açıldığında taşma olmaması için
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
            crossAxisAlignment:
                CrossAxisAlignment.start, // Textleri sola hizalar
            children: [
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Şifreni mi Unuttun?',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Hesabınızla ilişkili e-posta adresini girin, size şifrenizi sıfırlamanız için bir bağlantı gönderelim.',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 40),
              TextInputs(labelText: 'E-mail', controller: email, isEmail: true),

              SizedBox(height: 30),
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

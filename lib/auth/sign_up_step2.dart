import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horoscope/models/user_model.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:horoscope/widgets/text_inputs.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:horoscope/auth/verify_account.dart';

class SignUpStep2 extends StatefulWidget {
  final UserModel user;

  const SignUpStep2({super.key, required this.user});

  @override
  _SignUpStep2State createState() => _SignUpStep2State();
}

class _SignUpStep2State extends State<SignUpStep2> {
  final TextEditingController birthDateController = TextEditingController();
  String? selectedZodiac;

  final List<Map<String, dynamic>> zodiacSigns = [
    {"name": "Koç", "icon": MdiIcons.zodiacAries},
    {"name": "Boğa", "icon": MdiIcons.zodiacTaurus},
    {"name": "İkizler", "icon": MdiIcons.zodiacGemini},
    {"name": "Yengeç", "icon": MdiIcons.zodiacCancer},
    {"name": "Aslan", "icon": MdiIcons.zodiacLeo},
    {"name": "Başak", "icon": MdiIcons.zodiacVirgo},
    {"name": "Terazi", "icon": MdiIcons.zodiacLibra},
    {"name": "Akrep", "icon": MdiIcons.zodiacScorpio},
    {"name": "Yay", "icon": MdiIcons.zodiacSagittarius},
    {"name": "Oğlak", "icon": MdiIcons.zodiacCapricorn},
    {"name": "Kova", "icon": MdiIcons.zodiacAquarius},
    {"name": "Balık", "icon": MdiIcons.zodiacPisces},
  ];

  Future<void> registerUser() async {
    if (birthDateController.text.isEmpty && selectedZodiac == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Lütfen doğum tarihinizi veya burcunuzu seçin."),
        ),
      );
      return;
    }

    try {
      // Kullanıcıyı oluşturma
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: widget.user.email,
            password: widget.user.password,
          );

      User? user = userCredential.user;

      if (user != null) {
        // Kullanıcı adını güncelle
        await user.updateDisplayName(
          "${widget.user.fullName} ${widget.user.lastName}",
        );
        await user.reload();

        // Doğrulama e-postasını gönder
        await user.sendEmailVerification();

        // Kullanıcı bilgilerini Firestore'a kaydet
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "fullName": widget.user.fullName,
          "lastName": widget.user.lastName,
          "email": widget.user.email,
          "birthDate": birthDateController.text.trim(),
          "gender":
              widget.user.gender, // `gender` bilgisi Firestore'a eklendi! ✅
          "zodiacSign": selectedZodiac,
        });

        // Doğrulama ekranına yönlendir
        Get.offAll(() => const VerifyAccount());
      }
    } catch (e) {
      print("🚨 Firebase Kayıt Hatası: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Kayıt başarısız: $e")));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        birthDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
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
              Text(
                "Burcunuzu Seçiniz",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemCount: zodiacSigns.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedZodiac == zodiacSigns[index]["name"]
                              ? AppColors.accentColor
                              : Colors.grey[300],
                      foregroundColor:
                          selectedZodiac == zodiacSigns[index]["name"]
                              ? Colors.white
                              : Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedZodiac = zodiacSigns[index]["name"];
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(zodiacSigns[index]["icon"], size: 20),
                        SizedBox(width: 8),
                        Text(
                          zodiacSigns[index]["name"],
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "Doğum Tarihinizi Seçiniz",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextInputs(
                    labelText: "Doğum Tarihi",
                    controller: birthDateController,
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                label: "Kayıt Ol",
                onPressed: registerUser,
                backgroundColor: AppColors.accentColor,
                foregroundColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

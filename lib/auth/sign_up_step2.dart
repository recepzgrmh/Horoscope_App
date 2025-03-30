import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horoscope/models/user_model.dart';
import 'package:horoscope/services/auth_services.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/auth_forms.dart';
import 'package:horoscope/widgets/auth_text_inputs.dart';
import 'package:horoscope/widgets/auth_buttons.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'verify_account.dart';

/// Doğum tarihine göre burç belirleyen fonksiyon.
String getZodiacFromDate(DateTime birthDate) {
  int month = birthDate.month;
  int day = birthDate.day;
  if ((month == 3 && day >= 21) || (month == 4 && day <= 20))
    return "Koç";
  else if ((month == 4 && day >= 21) || (month == 5 && day <= 21))
    return "Boğa";
  else if ((month == 5 && day >= 22) || (month == 6 && day <= 21))
    return "İkizler";
  else if ((month == 6 && day >= 22) || (month == 7 && day <= 22))
    return "Yengeç";
  else if ((month == 7 && day >= 23) || (month == 8 && day <= 22))
    return "Aslan";
  else if ((month == 8 && day >= 23) || (month == 9 && day <= 22))
    return "Başak";
  else if ((month == 9 && day >= 23) || (month == 10 && day <= 22))
    return "Terazi";
  else if ((month == 10 && day >= 23) || (month == 11 && day <= 21))
    return "Akrep";
  else if ((month == 11 && day >= 22) || (month == 12 && day <= 21))
    return "Yay";
  else if ((month == 12 && day >= 22) || (month == 1 && day <= 20))
    return "Oğlak";
  else if ((month == 1 && day >= 21) || (month == 2 && day <= 19))
    return "Kova";
  else if ((month == 2 && day >= 20) || (month == 3 && day <= 20))
    return "Balık";
  else
    return "";
}

class SignUpStep2 extends StatefulWidget {
  final UserModel user;

  const SignUpStep2({super.key, required this.user});

  @override
  _SignUpStep2State createState() => _SignUpStep2State();
}

class _SignUpStep2State extends State<SignUpStep2> {
  final _formKey = GlobalKey<FormState>();
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
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    // Eğer doğum tarihi ve burç seçilmişse, uyum kontrolü yap
    if (birthDateController.text.isNotEmpty &&
        selectedZodiac != null &&
        !isBirthDateMatchingZodiac(
          birthDateController.text.trim(),
          selectedZodiac!,
        )) {
      Get.snackbar(
        "Hata",
        "Seçtiğiniz burç, doğum tarihinizle uyuşmuyor.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.cardColor,
        colorText: AppColors.primaryColor,
      );
      return;
    }

    try {
      final firebaseUser = await AuthService.signUp(
        user: widget.user,
        birthDate: birthDateController.text.trim(),
        zodiacSign: selectedZodiac,
      );
      if (firebaseUser != null) {
        Get.offAll(() => const VerifyAccount());
      }
    } catch (e) {
      Get.snackbar(
        "Kayıt Hatası",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.cardColor,
        colorText: AppColors.primaryColor,
      );
    }
  }

  // Yardımcı fonksiyon: Girilen doğum tarihine göre burç uyumunu kontrol eden fonksiyon (halihazırda var)
  bool isBirthDateMatchingZodiac(String birthDateStr, String zodiac) {
    final birthDate = DateFormat('dd-MM-yyyy').parse(birthDateStr);
    final int month = birthDate.month;
    final int day = birthDate.day;

    switch (zodiac) {
      case "Koç":
        return (month == 3 && day >= 21) || (month == 4 && day <= 20);
      case "Boğa":
        return (month == 4 && day >= 21) || (month == 5 && day <= 21);
      case "İkizler":
        return (month == 5 && day >= 22) || (month == 6 && day <= 21);
      case "Yengeç":
        return (month == 6 && day >= 22) || (month == 7 && day <= 22);
      case "Aslan":
        return (month == 7 && day >= 23) || (month == 8 && day <= 22);
      case "Başak":
        return (month == 8 && day >= 23) || (month == 9 && day <= 22);
      case "Terazi":
        return (month == 9 && day >= 23) || (month == 10 && day <= 22);
      case "Akrep":
        return (month == 10 && day >= 23) || (month == 11 && day <= 21);
      case "Yay":
        return (month == 11 && day >= 22) || (month == 12 && day <= 21);
      case "Oğlak":
        return (month == 12 && day >= 22) || (month == 1 && day <= 20);
      case "Kova":
        return (month == 1 && day >= 21) || (month == 2 && day <= 19);
      case "Balık":
        return (month == 2 && day >= 20) || (month == 3 && day <= 20);
      default:
        return false;
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
        // Otomatik olarak doğum tarihine göre burç belirle
        selectedZodiac = getZodiacFromDate(pickedDate);
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
      body: SafeArea(
        child: AuthForm(
          title: "Burcunuzu ve Doğum Tarihinizi Seçiniz",
          subtitle:
              "Burç seçerek veya doğum tarihinizi girerek devam edebilirsiniz.",
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: AuthTextInput(
                        labelText: "Doğum Tarihi",
                        controller: birthDateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Lütfen doğum tarihinizi giriniz";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Zodiac Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3,
                        ),
                    itemCount: zodiacSigns.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedZodiac = zodiacSigns[index]["name"];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                selectedZodiac == zodiacSigns[index]["name"]
                                    ? AppColors.accentColor
                                    : AppColors.cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  selectedZodiac == zodiacSigns[index]["name"]
                                      ? AppColors.primaryColor
                                      : Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                zodiacSigns[index]["icon"],
                                size: 24,
                                color:
                                    selectedZodiac == zodiacSigns[index]["name"]
                                        ? Colors.white
                                        : Colors.grey.shade600,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                zodiacSigns[index]["name"],
                                style: TextStyle(
                                  color:
                                      selectedZodiac ==
                                              zodiacSigns[index]["name"]
                                          ? Colors.white
                                          : AppColors.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            AuthButton(label: "Kayıt Ol", onPressed: registerUser),
          ],
        ),
      ),
    );
  }
}

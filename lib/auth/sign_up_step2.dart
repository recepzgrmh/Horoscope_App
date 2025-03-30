import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horoscope/services/auth_services.dart';
import '../models/user_model.dart';
import '../widgets/auth_forms.dart';
import '../widgets/auth_text_inputs.dart';
import '../widgets/auth_buttons.dart';
import 'verify_account.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../styles/app_colors.dart';

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
        const SnackBar(
          content: Text("Lütfen doğum tarihinizi veya burcunuzu seçin."),
        ),
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
      appBar: AppBar(toolbarHeight: 80, leading: const BackButton()),
      body: SafeArea(
        child: AuthForm(
          title: "Burcunuzu ve Doğum Tarihinizi Seçiniz",
          subtitle:
              "Burç seçerek veya doğum tarihinizi girerek devam edebilirsiniz.",
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                selectedZodiac == zodiacSigns[index]["name"]
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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: AuthTextInput(
                  labelText: "Doğum Tarihi",
                  controller: birthDateController,
                ),
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

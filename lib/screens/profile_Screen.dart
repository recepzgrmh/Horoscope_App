import 'package:flutter/material.dart';
import 'package:horoscope/opening.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<int?> calculateAge(String birthDateString) async {
    if (birthDateString.isEmpty) return null;

    DateFormat inputFormat = DateFormat('dd-MM-yyyy');
    DateTime birthDate = inputFormat.parse(birthDateString);

    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .get();

      if (doc.exists) {
        userData = doc.data() as Map<String, dynamic>;

        if ((userData?["birthDate"] ?? "").isNotEmpty) {
          int? userAge = await calculateAge(userData?["birthDate"]);

          if (userAge != null) {
            userData!["age"] = userAge.toString();

            // Kullanıcı yaşını Firestore'a güncelle
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user!.uid)
                .update({"age": userAge.toString()});
          }
        }

        setState(() {});
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => Opening()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text("Profil", style: TextStyle(fontSize: 22)),
        centerTitle: true,
        elevation: 1,
      ),
      body:
          userData == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profil İkonu
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.accentColor,
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Kullanıcı Bilgileri
                    profileItem("Ad", userData?["fullName"] ?? "Bilgi Eksik"),
                    profileItem(
                      "Soyad",
                      userData?["lastName"] ?? "Bilgi Eksik",
                    ),
                    profileItem("E-posta", userData?["email"] ?? "Bilgi Eksik"),
                    profileItem(
                      "Doğum Tarihi",
                      userData?["birthDate"] ?? "Bilgi Eksik",
                    ),
                    profileItem(
                      "Cinsiyet",
                      userData?["gender"] ?? "Bilgi Eksik",
                    ),
                    profileItem(
                      "Burç",
                      userData?["zodiacSign"] ?? "Bilgi Eksik",
                    ),
                    profileItem("Yaş", userData?["age"] ?? "Bilgi Eksik"),

                    const SizedBox(height: 40),

                    // Çıkış Yap Butonu
                    Center(
                      child: CustomButton(
                        label: 'Çıkış Yap',
                        onPressed: signOut,
                        backgroundColor: AppColors.accentColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget profileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 34, 27, 27),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

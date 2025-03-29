import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/opening.dart';
import 'package:horoscope/auth/verify_account.dart';
import 'package:horoscope/screens/animated_home_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    _reloadUser();
  }

  Future<void> _reloadUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.reload();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.emailVerified) {
              // Her cold start'te AnimatedHomeScreen gösterilsin,
              // AnimatedHomeScreen içindeki timer tamamlandığında MainScreen'e geçiş yapsın.
              return const AnimatedHomeScreen();
            } else {
              return const VerifyAccount();
            }
          } else {
            return const Opening();
          }
        },
      ),
    );
  }
}

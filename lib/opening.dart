import 'package:flutter/material.dart';
import 'package:horoscope/widgets/custom_button.dart';
import 'auth/sign_in.dart';
import 'auth/sign_up.dart';

class Opening extends StatelessWidget {
  const Opening({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  label: "Sign In!",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  verticalPadding: 16,
                  minHeight: 48,
                  elevation: 5,
                  borderRadius: BorderRadius.zero,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  label: "Sign Up!",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  verticalPadding: 16,
                  minHeight: 48,
                  elevation: 5,
                  borderRadius: BorderRadius.zero,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

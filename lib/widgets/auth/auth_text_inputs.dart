import 'package:flutter/material.dart';
import 'package:horoscope/widgets/text_inputs.dart';

class AuthTextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isEmail;
  final String? Function(String?)? validator;

  const AuthTextInput({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.isEmail = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputs(
      labelText: labelText,
      controller: controller,
      isPassword: isPassword,
      isEmail: isEmail,
      validator: validator,
    );
  }
}

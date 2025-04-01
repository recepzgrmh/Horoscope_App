import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const AuthForm({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

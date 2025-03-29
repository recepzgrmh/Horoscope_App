import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/social_card.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 16,
            right: 16,
            bottom: 10,
          ),
          child: Text(
            'Social',
            style: const TextStyle(
              fontSize: 20, // Daha büyük font
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SocialCard(
          title: "Join the Conversation: Horoscope Talks",
          description:
              "Discover what others are sharing about their horoscope experiences.",
          buttonText: "Explore Now",
          imagePath: "assets/images/sign-in.png",
          onPressed: () {},
        ),
        SizedBox(height: 6),
        SocialCard(
          title: "Horoscope Compatibility with Friends",
          description: "Find out how compatible you are with your friends.",
          buttonText: "Start Now",
          imagePath: "assets/images/sign-in.png",
          onPressed: () {},
          isReversed: true, // Bu kart ters düzen olacak
        ),
      ],
    );
  }
}

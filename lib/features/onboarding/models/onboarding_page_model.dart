import 'dart:ui';

class OnboardingPageModel {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  OnboardingPageModel({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  });
}
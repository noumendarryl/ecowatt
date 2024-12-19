import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/custom_elevated_button.dart';

class OnboardingPageContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const OnboardingPageContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 300,
        ),
        Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
            ),
        ),
        verticalSpaceSmall,
        Text(
          description,
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            ),
          textAlign: TextAlign.center,
        ),
        verticalSpaceMedium,
        CustomElevatedButton(
          label: buttonText,
          labelColor: Theme.of(context).colorScheme.onSurface,
          color: Theme.of(context).colorScheme.primary,
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}

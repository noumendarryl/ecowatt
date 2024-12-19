import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

import '../../../routing/app_router.gr.dart';
import '../models/onboarding_page_model.dart';
import 'onboarding_page_widget.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      OnboardingPageModel(
        image: 'assets/images/onboarding/onboarding.png',
        title: 'Welcome to Ecowatt',
        description:
            'Ecowatt helps households monitor their energy consumption and save money',
        buttonText: 'Get Started',
        onButtonPressed: () {
          context.pushRoute(Register());
        },
      ),
      OnboardingPageModel(
        image: 'assets/images/onboarding/tracking.png',
        title: 'Track your energy usage',
        description:
            'Easily track your energy consumption and identify areas for improvement',
        buttonText: 'Learn More',
        onButtonPressed: () {
          // Navigate to the next screen
        },
      ),
      OnboardingPageModel(
        image: 'assets/images/onboarding/savings.png',
        title: 'Save money on your bills',
        description:
            'Optimize your energy usage and save on your monthly energy bills',
        buttonText: 'Start Saving',
        onButtonPressed: () {
          context.pushRoute(Login());
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: smallSize, vertical: mediumSize),
          child: OnboardingPageWidget(pages: pages),
        ),
      ),
    );
  }
}

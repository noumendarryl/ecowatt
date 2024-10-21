import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

import '../../../routing/app_router.gr.dart';
import '../../../shared/widgets/button.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: smallSize, vertical: mediumSize),
        child: Column(
          children: [
            verticalSpaceLarge,
            Image.asset(
              "assets/images/logo/ecowatt.png",
              height: size.height * 0.15,
            ),
            verticalSpaceLarge,
            Text(
              "Welcome To",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge!.fontFamily,
                  fontSize: Theme.of(context).textTheme.displayLarge!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.displayLarge!.fontWeight),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "EcoWatt",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily:
                          Theme.of(context).textTheme.headlineLarge!.fontFamily,
                      fontSize:
                          Theme.of(context).textTheme.displayLarge!.fontSize,
                      fontWeight: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .fontWeight),
                ),
                horizontalSpaceTiny,
                Text(
                  ' !',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontFamily:
                          Theme.of(context).textTheme.headlineLarge!.fontFamily,
                      fontSize:
                          Theme.of(context).textTheme.displayLarge!.fontSize,
                      fontWeight: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .fontWeight),
                ),
              ],
            ),
            verticalSpaceMedium,
            Text(
              "Your personal assistant for smarter energy use. Monitor, track, and optimize your electricity consumption in real-time. Save energy, reduce costs, and contribute to a greener future right from your fingertips.",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily:
                      Theme.of(context).textTheme.bodyMedium!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Column(
              children: [
                Button(
                  label: "Sign up",
                  onPressed: () {
                    context.pushRoute(Register());
                  },
                ),
                verticalSpaceSmall,
                Button(
                  label: "Sign in",
                  outlined: true,
                  onPressed: () {
                    context.pushRoute(Login());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

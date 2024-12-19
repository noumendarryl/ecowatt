import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routing/app_router.gr.dart';
import '../../../shared/widgets/blink_image.dart';
import '../logic/bootstrap_cubit.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BootstrapCubit()..init(),
      child: BlocListener<BootstrapCubit, BootstrapState>(
        listener: (context, state) {
          state.maybeWhen(
              initialized: (isLoggedIn) {
                if (isLoggedIn) {
                  context.pushRoute(const HomeRoute());
                } else {
                  context.pushRoute(const OnboardingRoute());
                }
              },
              orElse: () {});
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: const Center(
            child: BlinkingImage(
              imagePath: 'assets/images/logo/ecowatt.png',
              blinkDuration: Duration(milliseconds: 300),
              pauseDuration: Duration(seconds: 2),
            ),
          ),
        ),
      ),
    );
  }
}

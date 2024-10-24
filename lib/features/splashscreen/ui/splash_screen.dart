import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routing/app_router.gr.dart';
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
                  context.pushRoute(const WelcomeRoute());
                }
              },
              orElse: () {});
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Center(
            child: Image.asset(
                "images/logo/ecowatt.png",
            ),
          ),
        ),
      ),
    );
  }
}

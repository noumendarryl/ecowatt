import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/logic/auth_cubit.dart';
import '../../features/auth/logic/auth_state.dart';
import 'button.dart';

class Footer extends StatelessWidget {
  final Size size;

  const Footer({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width / 2.5,
                height: 1.0,
                child: Container(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
              horizontalSpaceSmall,
              Text(
                "OR",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
              horizontalSpaceSmall,
              SizedBox(
                width: size.width / 2.5,
                height: 1.0,
                child: Container(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ],
          ),
          verticalSpaceSmall,
          Wrap(
            runSpacing: smallSize,
            children: [
              Button(
                label: 'Continue with Google',
                padding: smallSize,
                primary: false,
                prefix: Image.asset(
                  "assets/images/brands/google.png",
                  height: size.height * 0.05,
                ),
                onPressed: () {
                  context.read<AuthCubit>().signInWithGoogle();
                },
              ),
              Button(
                label: 'Continue with Apple',
                padding: smallSize + 3.0,
                primary: false,
                prefix: Image.asset(
                  "assets/images/brands/apple.png",
                  height: size.height * 0.035,
                ),
                onPressed: () {
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}

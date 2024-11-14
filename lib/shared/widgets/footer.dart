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
                width: size.width / 3,
                height: 2.0,
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
                    ?.copyWith(color: Theme.of(context).colorScheme.onTertiary),
              ),
              horizontalSpaceSmall,
              SizedBox(
                width: size.width / 3,
                height: 2.0,
                child: Container(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Wrap(
            runSpacing: smallSize,
            children: [
              Button(
                label: 'Continue with Google',
                primary: false,
                prefix: Image.asset(
                  "images/brands/google.png",
                  height: size.height * 0.05,
                ),
                onPressed: () {
                  context.read<AuthCubit>().signInWithGoogle();
                },
              ),
              Button(
                label: 'Continue with Apple',
                primary: false,
                prefix: Image.asset(
                 "images/brands/apple.png",
                  height: size.height * 0.04,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      );
    });
  }
}

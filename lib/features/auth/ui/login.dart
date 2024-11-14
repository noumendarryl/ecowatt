import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exceptions/custom_dialog.dart';
import '../../../routing/app_router.gr.dart';
import '../../../shared/widgets/footer.dart';
import '../../../shared/widgets/form_layout.dart';
import '../../../shared/widgets/text_rich.dart';
import '../logic/auth_cubit.dart';
import '../logic/auth_state.dart';

@RoutePage()
class Login extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
            authenticated: (user) {
              showCustomSnackbar(
                title: "User Login successful",
                message: "Your account has been validated for login",
                type: SnackbarType.success,
              );
              context.pushRoute(const HomeRoute());
            },
            unauthenticated: () {
              showCustomSnackbar(
                title: "User Authentication Failed",
                message:
                    "You failed to login with these credentials. Please try again.",
                type: SnackbarType.error,
              );
            },
            orElse: () {});
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: smallSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: largeSize),
                      child: Center(
                        child: Image.asset(
                          "images/logo/ecowatt.png",
                          height: size.height * 0.2,
                        ),
                      )
                    ),
                    Text(
                      "Welcome Back !",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.scrim,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .fontFamily,
                          fontSize: 38.0,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .fontWeight),
                    ),
                    verticalSpaceSmall,
                    Text(
                      "Please enter your credentials to continue",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontFamily:
                            Theme.of(context).textTheme.bodySmall!.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                      ),
                    ),
                    verticalSpaceMedium,
                    FormLayout(
                      formKey: _formKey,
                      // isLoading:
                      label: "Sign in",
                      emailController: _emailController,
                      passwordController: _passwordController,
                      onAction: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<AuthCubit>().signInWithEmail(
                              _emailController.text.toLowerCase(),
                              _passwordController.text.trim());
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: TextRich(
                        secondaryText: "Lost password ?",
                        onClick: () {},
                      ),
                    ),
                    verticalSpaceSmall,
                    Footer(
                      size: size,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35.0),
                      child: TextRich(
                        primaryText: "Don't have an account yet ?",
                        secondaryText: " Sign up",
                        alignment: Alignment.center,
                        onClick: () {
                          context.pushRoute(Register());
                        },
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

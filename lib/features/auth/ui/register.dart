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
class Register extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Register({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
            signUpSuccess: () {
              showCustomSnackbar(
                title: "User registration successful",
                message: "Your account has been created successfully",
                type: SnackbarType.success,
              );
              context.pushRoute(Login());
            },
            signUpFailed: (user) {
              showCustomSnackbar(
                title: "User Signup Failed",
                message: "Your account hasn't been created. Please try again.",
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
                padding: const EdgeInsets.symmetric(
                    horizontal: smallSize, vertical: mediumSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: mediumSize),
                        child: Center(
                          child: Image.asset(
                            "images/logo/ecowatt.png",
                            height: size.height * 0.1,
                          ),
                        )),
                    Text(
                      "Join us now !",
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
                      "Monitor your energy consumption with Ecowatt",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontFamily:
                            Theme.of(context).textTheme.bodySmall!.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge!.fontSize,
                      ),
                    ),
                    verticalSpaceMedium,
                    FormLayout(
                      formKey: _formKey,
                      isDisplayName: true,
                      isUsername: true,
                      isConfirmPassword: true,
                      label: "Sign up",
                      displayNameController: _displayNameController,
                      usernameController: _usernameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      onAction: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<AuthCubit>().signUpWithEmail(
                              _displayNameController.text.trim(),
                              _usernameController.text.trim(),
                              _emailController.text.toLowerCase(),
                              _passwordController.text.trim()
                          );
                          _formKey.currentState!.reset();
                          // context.pushRoute(Login());
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: mediumSize),
                      child: TextRich(
                        primaryText: "Already have an account ?",
                        secondaryText: "  Sign in",
                        alignment: Alignment.center,
                        onClick: () {
                          context.pushRoute(Login());
                        },
                      ),
                    ),
                    verticalSpaceSmall,
                    Footer(
                      size: size,
                    ),
                    verticalSpaceMedium,
                    TextRich(
                      primaryText: "Learn more about",
                      secondaryText: " Ecowatt",
                      alignment: Alignment.center,
                      onClick: () {},
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

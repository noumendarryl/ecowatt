import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:file_picker/file_picker.dart';

import '../utils/formatters.dart';
import 'button.dart';
import 'input.dart';

class FormLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String label;
  final Function() onAction;
  final bool? isAvatar;
  final bool? isDisplayName;
  final String? displayNameValue;
  final TextEditingController? displayNameController;
  final bool? isUsername;
  final String? usernameValue;
  final TextEditingController? usernameController;
  final bool? isEmail;
  final String? emailValue;
  final TextEditingController? emailController;
  final bool? isPassword;
  final TextEditingController? passwordController;
  final bool? isConfirmPassword;
  final TextEditingController? confirmPasswordController;
  final bool? isNumber;
  final String? phoneValue;
  final TextEditingController? phoneController;
  final bool? isLoading;
  final bool? emailDisabled;
  final bool? isCancel;
  final double? gap;

  final RxBool _isPasswordVisible = true.obs;
  final RxBool _isConfirmPasswordVisible = true.obs;

  FormLayout({
    super.key,
    required this.formKey,
    required this.label,
    required this.onAction,
    this.isAvatar = false,
    this.isUsername = false,
    this.usernameValue,
    this.usernameController,
    this.isDisplayName = false,
    this.displayNameValue,
    this.displayNameController,
    this.isEmail = true,
    this.emailValue,
    this.emailController,
    this.isPassword = true,
    this.passwordController,
    this.isConfirmPassword = false,
    this.confirmPasswordController,
    this.isNumber = false,
    this.phoneValue,
    this.phoneController,
    this.isLoading = false,
    this.emailDisabled = false,
    this.isCancel = false,
    this.gap = 5.0,
  });

  static String? avatar;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: mediumSize,
        children: [
          if (isAvatar!)
            UserAvatar(onAction: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );
              if (result != null) {
                print(result.files.single.path!);
              }
            }),
          Wrap(
            runSpacing: smallSize + gap!,
            children: [
              if (isDisplayName!)
                Input(
                  label: "Display Name",
                  controller: displayNameController!,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(CupertinoIcons.person),
                ),
              if (isUsername!)
                Input(
                  label: "Username",
                  controller: usernameController!,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(CupertinoIcons.person),
                ),
              if (isEmail!)
                Input(
                  label: "Email address",
                  controller: emailController!,
                  keyboardType: TextInputType.emailAddress,
                  disabled: emailDisabled,
                  suffixIcon: const Icon(
                    CupertinoIcons.mail,
                  ),
                  validator: (String? value) {
                    if (!Formatters.isEmailValid(value!)) {
                      return "Email has an invalid format";
                    }
                    return null;
                  },
                ),
              if (isPassword!)
                Obx(
                  () => Input(
                    label: "Password",
                    isObscured: _isPasswordVisible.value,
                    controller: passwordController!,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (String? value) {
                      return Formatters.checkPassword(value!,
                          confirmPassword: isConfirmPassword!
                              ? confirmPasswordController!.text.trim()
                              : null);
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isPasswordVisible.value = !_isPasswordVisible.value;
                      },
                      icon: Icon(
                        _isPasswordVisible.value
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                      ),
                    ),
                  ),
                ),
              if (isConfirmPassword!)
                Obx(
                  () => Input(
                    label: "Confirm Password",
                    isObscured: _isConfirmPasswordVisible.value,
                    controller: confirmPasswordController!,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (String? value) {
                      if (!Formatters.isPasswordConfirmed(
                          passwordController!.text.trim(), value)) {
                        return "Password and confirm password must be the same";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isConfirmPasswordVisible.value =
                            !_isConfirmPasswordVisible.value;
                      },
                      icon: Icon(
                        _isConfirmPasswordVisible.value
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                      ),
                    ),
                  ),
                ),
              if (isNumber!)
                Input(
                  label: "Phone Number",
                  controller: phoneController!,
                  keyboardType: TextInputType.number,
                  suffixIcon: const Icon(
                    CupertinoIcons.phone,
                  ),
                ),
            ],
          ),
          Wrap(
            runSpacing: isCancel! ? mediumSize : 0.0,
            children: [
              Button(label: label, isLoading: isLoading, onPressed: onAction),
              if (isCancel!)
                Button(
                    label: "Cancel",
                    primary: false,
                    outlined: true,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.reset();
                      }
                    })
            ],
          ),
        ],
      ),
    );
  }
}

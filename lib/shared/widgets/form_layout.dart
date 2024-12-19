import 'dart:io';

import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/widgets/user_avatar.dart';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../utils/formatters.dart';
import 'button.dart';
import 'input.dart';

class FormLayout extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String label;
  final Function() onAction;
  final Function()? pickImage;
  final bool? isAvatar;
  final String? photoUrl;
  File? avatar;
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
  final bool? isCancel;
  final double? gap;

  FormLayout({
    super.key,
    required this.formKey,
    required this.label,
    required this.onAction,
    this.pickImage,
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
    this.isCancel = false,
    this.gap = 5.0,
    this.photoUrl,
    this.avatar,
  });

  @override
  State<FormLayout> createState() => _FormLayoutState();
}

class _FormLayoutState extends State<FormLayout> {
  final RxBool _isPasswordVisible = true.obs;

  final RxBool _isConfirmPasswordVisible = true.obs;

  //static String? avatar;
  // Future<void> _pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       widget.avatar = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: mediumSize,
        children: [
          if (widget.isAvatar!)
            UserAvatar(
              // Utiliser UserAvatar ici
              width: 100.0,
              // Définissez la largeur souhaitée
              height: 100.0,
              // Définissez la hauteur souhaitée
              avatar: widget.avatar,
              // Utilisez _profileImage pour l'image locale
              photoURL: widget.photoUrl,
              // Utilisez photoURL de l'utilisateur
              onAction: () {
                // Ouvrir le sélecteur d'images lorsque l'utilisateur clique sur l'avatar
                widget.pickImage!();
              },
            ),
          Wrap(
            runSpacing: smallSize + widget.gap!,
            children: [
              if (widget.isDisplayName!)
                Input(
                  label: "Display Name",
                  controller: widget.displayNameController!,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.person),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Display Name is required";
                    }
                    return null;
                  },
                ),
              if (widget.isUsername!)
                Input(
                  label: "Username",
                  controller: widget.usernameController!,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.person),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                ),
              if (widget.isEmail!)
                Input(
                  label: "Email address",
                  controller: widget.emailController!,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(
                    Icons.email,
                  ),
                  validator: (String? value) {
                    if (!Formatters.isEmailValid(value!)) {
                      return "Email has an invalid format";
                    }
                    return null;
                  },
                ),
              if (widget.isPassword!)
                Obx(
                  () => Input(
                    label: "Password",
                    isObscured: _isPasswordVisible.value,
                    controller: widget.passwordController!,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (String? value) {
                      return Formatters.checkPassword(value!,
                          confirmPassword: widget.isConfirmPassword!
                              ? widget.confirmPasswordController!.text.trim()
                              : null);
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isPasswordVisible.value = !_isPasswordVisible.value;
                      },
                      icon: Icon(
                        _isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),
              if (widget.isConfirmPassword!)
                Obx(
                  () => Input(
                    label: "Confirm Password",
                    isObscured: _isConfirmPasswordVisible.value,
                    controller: widget.confirmPasswordController!,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (String? value) {
                      if (!Formatters.isPasswordConfirmed(
                          widget.passwordController!.text.trim(), value)) {
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
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),
              if (widget.isNumber!)
                Input(
                  label: "Phone Number",
                  controller: widget.phoneController!,
                  keyboardType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.phone,
                  ),
                ),
            ],
          ),
          Wrap(
            runSpacing: widget.isCancel! ? mediumSize : 0.0,
            children: [
              Button(
                  label: widget.label,
                  padding: smallSize,
                  isLoading: widget.isLoading,
                  onPressed: widget.onAction),
              if (widget.isCancel!)
                Button(
                    label: "Cancel",
                    padding: smallSize,
                    primary: false,
                    outlined: true,
                    onPressed: () {
                      if (widget.formKey.currentState!.validate()) {
                        widget.formKey.currentState!.reset();
                      }
                    })
            ],
          ),
        ],
      ),
    );
  }
}

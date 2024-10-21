import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final String? initialValue;
  final TextEditingController controller;
  final TextStyle? style;
  final TextInputType keyboardType;
  final double? width;
  final int? maxLines;
  final int? maxLength;
  final bool isObscured;
  final String obscuringChar;
  final bool? primary;
  final bool? disabled;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Function()? onSubmit;

  const Input({
    super.key,
    this.label,
    this.placeholder,
    this.initialValue,
    required this.controller,
    this.style,
    required this.keyboardType,
    this.width,
    this.maxLines,
    this.maxLength,
    this.isObscured = false,
    this.obscuringChar = '•',
    this.primary = true,
    this.disabled = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: TextFormField(
          controller: controller,
          initialValue: initialValue,
          style: style ?? _getTextFormFieldTextStyle(context),
          obscureText: isObscured,
          obscuringCharacter: obscuringChar,
          enabled: !disabled!,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: _getTextFormFieldBorder(context)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: _getTextFormFieldBorder(context)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                      width: 2.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                      width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0)),
              filled: disabled,
              fillColor: _getTextFormFieldColor(context),
              prefixIcon: prefixIcon,
              prefixIconColor: _getTextFormFieldIconStyle(context),
              labelText: placeholder ?? label,
              labelStyle: _getTextFormFieldTextStyle(context),
              // errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //     color: Theme.of(context).colorScheme.error),
              suffixIcon: suffixIcon,
              suffixIconColor: _getTextFormFieldIconStyle(context)),
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          onChanged: onChanged != null ? (value) => onChanged!(value) : null,
          onFieldSubmitted: (_) => onSubmit,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your ${label!.toLowerCase()}';
            }

            // Call the provided validator function
            if (validator != null) {
              final res = validator!(value);
              if (res != null) {
                return res;
              }
            }

            return null;
          },
        ));
  }

  Color _getTextFormFieldColor(BuildContext context) {
    if (disabled!) {
      return Theme.of(context).colorScheme.onTertiary;
    } else {
      return Colors.transparent;
    }
  }

  BorderSide _getTextFormFieldBorder(BuildContext context) {
    if (disabled!) {
      return BorderSide.none;
    } else {
      return BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
          width: 2.0);
    }
  }

  TextStyle? _getTextFormFieldTextStyle(BuildContext context) {
    if (disabled!) {
      return Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onTertiary, fontSize: Theme.of(context).textTheme.bodySmall?.fontSize);
    } else if (primary!) {
      return Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.tertiary, fontSize: Theme.of(context).textTheme.bodySmall?.fontSize);
    } else {
      return Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onTertiary, fontSize: Theme.of(context).textTheme.bodySmall?.fontSize);
    }
  }

  Color? _getTextFormFieldIconStyle(BuildContext context) {
    if (disabled!) {
      return Theme.of(context).colorScheme.onTertiary;
    } else if (primary!) {
      return Theme.of(context).colorScheme.tertiary;
    } else {
      return Theme.of(context).colorScheme.onTertiary;
    }
  }
}

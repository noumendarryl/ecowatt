import 'package:flutter/material.dart';

enum BorderType { disabled, enabled, focused, error, focusedError }

class Input extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? initialValue;
  final TextEditingController controller;
  final TextStyle? style;
  final TextInputType keyboardType;
  final double? width;
  final int? maxLines;
  final int? maxLength;
  final double radius;
  final bool isObscured;
  final String obscuringChar;
  final bool? primary;
  final bool? outlined;
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
    this.radius = 8.0,
    this.isObscured = false,
    this.obscuringChar = '•',
    this.primary = true,
    this.outlined = true,
    this.disabled = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmit,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _isValid = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            style: widget.style ?? _getTextFormFieldTextStyle(context),
            obscureText: widget.isObscured,
            obscuringCharacter: widget.obscuringChar,
            enabled: !widget.disabled!,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
                disabledBorder: _getBorder(context, BorderType.disabled),
                enabledBorder: _getBorder(context, BorderType.enabled),
                errorBorder: _getBorder(context, BorderType.error),
                focusedErrorBorder: _getBorder(context, BorderType.focusedError),
                focusedBorder: _getBorder(context, BorderType.focused),
                filled: widget.disabled,
                fillColor: _getTextFormFieldColor(context),
                prefixIcon: _getIconWithColor(context, widget.prefixIcon),
                prefixIconColor: _getIconColor(context),
                hintText: widget.placeholder ?? widget.label,
                hintStyle: _getTextFormFieldTextStyle(context),
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
                suffixIcon: _getIconWithColor(context, widget.suffixIcon),
                suffixIconColor: _getIconColor(context)),
            maxLines: widget.maxLines ?? 1,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged != null ? (value) => widget.onChanged!(value) : null,
            onFieldSubmitted: (_) => widget.onSubmit,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                _isValid = true;
                return 'Please enter your ${widget.label!.toLowerCase()}';
              }
          
              // Call the provided validator function
              if (widget.validator != null) {
                final res = widget.validator!(value);
                if (res != null) {
                  _isValid = false;
                  return res;
                }
              }

              _isValid = false;
          
              return null;
            },
          ),
        ));
  }

  InputBorder _getBorder(BuildContext context, BorderType type) {
    BorderSide borderSide;

    switch (type) {
      case BorderType.disabled:
        borderSide = BorderSide.none;
        break;
      case BorderType.error:
      case BorderType.focusedError:
        borderSide = BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 1.0,
        );
        break;
      case BorderType.focused:
        borderSide = BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.0,
        );
        break;
      case BorderType.enabled:
      default:
        borderSide = widget.disabled!
            ? BorderSide.none
            : BorderSide(
                color: Theme.of(context).colorScheme.onTertiary,
                width: 1.0,
              );
    }

    return widget.outlined!
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: borderSide,
          )
        : UnderlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: borderSide,
          );
  }

  Color _getTextFormFieldColor(BuildContext context) {
    return widget.disabled!
        ? Theme.of(context).colorScheme.onTertiary
        : Colors.transparent;
  }

  TextStyle? _getTextFormFieldTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: widget.disabled!
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.tertiary,
          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
        );
  }

  Color _getIconColor(BuildContext context) {
  if (widget.disabled!) {
    return Theme.of(context).colorScheme.onTertiary;
  }

  // Use the same color logic as in _getBorder method
  switch (_getCurrentBorderType()) {
    case BorderType.disabled:
      return Theme.of(context).colorScheme.onTertiary;
    case BorderType.error:
      return Theme.of(context).colorScheme.error;
    case BorderType.focusedError:
      return Theme.of(context).colorScheme.error;
    case BorderType.focused:
      return Theme.of(context).colorScheme.primary;
    case BorderType.enabled:
      return Theme.of(context).colorScheme.onTertiary;
    default:
      return Theme.of(context).colorScheme.onTertiary;
  }
}

BorderType _getCurrentBorderType() {
  // First, check if the input is disabled
  if (widget.disabled!) return BorderType.disabled;

  // If there's a validation error
  if (_isValid) {
    return _isFocused ? BorderType.focusedError : BorderType.error;
  }

  // If no validation error, check focus state
  if (_isFocused) {
    return BorderType.focused;
  }

  // Default to enabled state
  return BorderType.enabled;
}

  Widget? _getIconWithColor(BuildContext context, dynamic icon) {
    if (icon == null) return null;

    // If icon is already a Widget, wrap it with a color
    if (icon is Widget) {
      return IconTheme(
        data: IconThemeData(
          color: _getIconColor(context),
        ),
        child: icon,
      );
    }

    // If icon is an IconData, create an Icon with the dynamic color
    if (icon is IconData) {
      return Icon(
        icon,
        color: _getIconColor(context),
      );
    }

    return icon;
  }

  BorderSide _getTextFormFieldBorder(BuildContext context) {
    if (widget.disabled!) {
      return BorderSide.none;
    } else {
      return BorderSide(
          color: Theme.of(context).colorScheme.onTertiary, width: 1.0);
    }
  }
}

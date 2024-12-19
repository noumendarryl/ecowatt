import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final bool? isLoading;
  final bool? primary;
  final bool? tertiary;
  final bool? outlined;
  final bool? disabled;
  final Widget? prefix;
  final Widget? suffix;
  final Function() onPressed;

  const Button(
      {super.key,
        required this.label,
        this.width,
        this.height,
        this.radius,
        this.padding = smallSize +  5.0,
        this.isLoading = false,
        this.primary = true,
        this.tertiary = false,
        this.outlined = false,
        this.disabled = false,
        this.prefix,
        this.suffix,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: disabled! ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.scrim,
          backgroundColor: _getButtonColor(context),
          padding: EdgeInsets.all(padding!),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? smallSize),
              side: _getButtonBorder(context)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefix != null)
              Padding(
                padding: const EdgeInsets.only(right: smallSize),
                child: prefix!,
              ),
            isLoading!
                ? Center(
                child: SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ))
                : Text(label, style: _getButtonTextStyle(context)),
            if (suffix != null)
              Padding(
                padding: const EdgeInsets.only(left: smallSize),
                child: suffix!,
              ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(BuildContext context) {
    if (disabled!) {
      if (outlined!) {
        return Colors.transparent;
      }
      return Theme.of(context).colorScheme.onTertiary;
    } else if (primary!) {
      if (outlined!) {
        return Colors.transparent;
      }
      return Theme.of(context).colorScheme.primary;
    } else {
      if (outlined!) {
        return Colors.transparent;
      }
      return Theme.of(context).colorScheme.tertiary.withOpacity(0.1);
    }
  }

  BorderSide _getButtonBorder(BuildContext context) {
    if (outlined!) {
      if (primary!) {
        return BorderSide(
            color: Theme.of(context).colorScheme.primary, width: 2.0);
      }
      return BorderSide(
          color: Theme.of(context).colorScheme.secondary, width: 2.0);
    } else {
      return BorderSide.none;
    }
  }

  TextStyle? _getButtonTextStyle(BuildContext context) {
    if (disabled!) {
      if (outlined!) {
        return Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.tertiary);
      }
      return Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.tertiary);
    } else if (outlined!) {
      return Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.primary);
    } else if (primary!) {
      return Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface);
    } else {
      return Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(color: Theme.of(context).colorScheme.tertiary);
    }
  }
}

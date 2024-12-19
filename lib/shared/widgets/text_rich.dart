import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextRich extends StatelessWidget {
  final String? primaryText;
  final String secondaryText;
  final Alignment? alignment;
  final Function()? onClick;

  const TextRich(
      {super.key,
      this.primaryText,
      required this.secondaryText,
      this.alignment,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.topRight,
      child: Text.rich(
        TextSpan(
            text: primaryText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily,
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
            ),
            children: [
              TextSpan(
                text: secondaryText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily:
                      Theme.of(context).textTheme.titleSmall!.fontFamily,
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.titleSmall!.fontWeight,
                ),
                recognizer: TapGestureRecognizer()..onTap = onClick,
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}

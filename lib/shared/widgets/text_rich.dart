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
              color: Theme.of(context).colorScheme.scrim,
              fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            ),
            children: [
              TextSpan(
                text: secondaryText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily:
                      Theme.of(context).textTheme.bodyMedium!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.bodyMedium!.fontWeight,
                ),
                recognizer: TapGestureRecognizer()..onTap = onClick,
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}

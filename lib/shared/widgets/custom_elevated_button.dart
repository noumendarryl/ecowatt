import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final String label;
  final Color labelColor;
  final Color color;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    this.width = 40.0,
    this.height = 10.0,
    this.radius = 10.0,
    required this.onPressed,
    required this.label,
    required this.labelColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: labelColor,
          fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

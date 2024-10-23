import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String btnLabel;
  final Color btnColor;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,

    required this.onPressed, required this.btnLabel, required this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor, // Couleur du bouton
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(btnLabel),
    );
  }
}

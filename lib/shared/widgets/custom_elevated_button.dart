import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnLabel;
  final Color btnColor;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,

    required this.onPressed, required this.btnLabel, required this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(btnLabel),
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor, // Couleur du bouton
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

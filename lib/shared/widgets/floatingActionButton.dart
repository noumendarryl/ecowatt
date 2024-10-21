import 'package:flutter/material.dart';

class BuildFloatingActionButton extends StatelessWidget {
  const BuildFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Logique pour l'action centrale
      },
      child: Icon(Icons.add, size: 30),
      backgroundColor: Colors.purple,
      elevation: 5,
    );
  }
}

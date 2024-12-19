import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

class BuildFloatingActionButton extends StatelessWidget {
  const BuildFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Logique pour l'action centrale
      },
      backgroundColor: Colors.purple,
      elevation: 5,
      child: const Icon(Icons.add, size: smallSize + 10),
    );
  }
}

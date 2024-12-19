import 'dart:io';

import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double? width;
  final double? height;
  final double? iconSize;
  final String? photoURL;
  final File? avatar;
  final Function()? onAction;

  const UserAvatar(
      {super.key,
      this.width = 120.0,
      this.height = 120.0,
      this.iconSize = smallSize,
      this.avatar,
      this.onAction,
      this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      child: GestureDetector(
        onTap: onAction,
        child: CircleAvatar(
          radius: width! / 2, // Utilisez la largeur pour définir le rayon
          backgroundImage: avatar != null
              ? FileImage(avatar!) // Afficher l'image si disponible
              : (photoURL != null && photoURL!.isNotEmpty
                  ? NetworkImage(
                      photoURL!) // Afficher l'image réseau si disponible
                  : null), // Pas d'image par défaut
          child: (avatar == null && (photoURL == null || photoURL!.isEmpty))
              ? Icon(Icons.person,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 50) // Icône par défaut si aucune image
              : null,
        ),
      ),
    );
  }
}

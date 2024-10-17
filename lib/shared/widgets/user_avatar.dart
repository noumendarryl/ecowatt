import 'dart:io';

import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double? width;
  final double? height;
  final double? iconSize;
  final File? avatar;
  final Function()? onAction;

  const UserAvatar(
      {super.key,
      this.width = 120.0,
      this.height = 120.0,
      this.iconSize = smallSize,
      this.avatar,
      this.onAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: ClipOval(
        child: GestureDetector(
          onTap: onAction,
          child: avatar != null
              ? Image.file(
                  avatar!,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                )
              : Icon(
                  Icons.add_photo_alternate,
                  color: Theme.of(context).colorScheme.primary,
                  size: iconSize,
                ),
        ),
      ),
    );
  }
}

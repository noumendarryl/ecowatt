import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomUtils {
  Color getCardBackgroundColor(BuildContext context, String room) {
    switch (room) {
      case "Bed Room":
        return Theme.of(context).colorScheme.primary;
      case "Kitchen":
        return Theme.of(context).colorScheme.secondary;
      case "Living Room":
        return Theme.of(context).colorScheme.secondary;
      case "Dining Room":
        return Theme.of(context).colorScheme.scrim;
      case "Office Room":
        return Theme.of(context).colorScheme.onError;
      case "Bath Room":
        return Theme.of(context).colorScheme.surface;
      case "Laundry Room":
        return Theme.of(context).colorScheme.outlineVariant;
      default:
        return Theme.of(context).colorScheme.tertiary;
    }
  }

  IconData getCardIcon(String room) {
    switch (room) {
      case "Bed Room":
        return CupertinoIcons.bed_double_fill;
      case "Kitchen":
        return CupertinoIcons.burn;
      case "Living Room":
        return CupertinoIcons.tv;
      case "Dining Room":
        return CupertinoIcons.square_grid_2x2_fill;
      case "Office Room":
        return CupertinoIcons.desktopcomputer;
      case "Bath Room":
        return CupertinoIcons.drop_fill;
      case "Laundry Room":
        return CupertinoIcons.square_stack_3d_up_fill;
      default:
        return CupertinoIcons.car_detailed;
    }
  }
}
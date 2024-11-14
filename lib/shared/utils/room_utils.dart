import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomUtils {
  Color getCardBackgroundColor(BuildContext context, String room) {
    switch (room) {
      case "Bed Room":
        return Theme.of(context).colorScheme.onSecondary;
      case "Kitchen":
        return Theme.of(context).colorScheme.scrim;
      case "Living Room":
        return Theme.of(context).colorScheme.outline;
      case "Dining Room":
        return Theme.of(context).colorScheme.primary;
      case "Office Room":
        return Theme.of(context).colorScheme.error;
      case "Bath Room":
        return Theme.of(context).colorScheme.outlineVariant;
      case "Laundry Room":
        return Theme.of(context).colorScheme.secondary;
      default:
        return Theme.of(context).colorScheme.surface;
    }
  }

  IconData getCardIcon(String room) {
    switch (room) {
      case "Bed Room":
        return CupertinoIcons.bed_double_fill;
      case "Kitchen":
        return Icons.kitchen;
      case "Living Room":
        return CupertinoIcons.tv;
      case "Dining Room":
        return Icons.restaurant_menu;
      case "Office Room":
        return CupertinoIcons.desktopcomputer;
      case "Bath Room":
        return CupertinoIcons.drop_fill;
      case "Laundry Room":
        return Icons.local_laundry_service;
      default:
        return CupertinoIcons.car_detailed;
    }
  }
}
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomUtils {
  // Custom hash function to generate a consistent integer from a string
  static int _generateHashCode(String identifier) {
    int hash = 0;
    for (int i = 0; i < identifier.length; i++) {
      hash = 31 * hash + identifier.codeUnitAt(i);
    }
    return hash.abs();
  }

  // Generate a consistent random color for a specific identifier
  static Color generateStaticRandomColor(String identifier) {
    // Use a hash of the identifier to generate a consistent seed
    final int hash = _generateHashCode(identifier);

    // Use Random with a fixed seed to ensure consistency
    final Random random = Random(hash);

    // Generate a color with controlled saturation and brightness
    return Color.fromRGBO(
        random.nextInt(180) + 20,  // Red (20-200)
        random.nextInt(180) + 20,  // Green (20-200)
        random.nextInt(180) + 20,  // Blue (20-200)
        1.0  // Full opacity
    );
  }

  // Alternative method using persistent storage
  static Future<Color> getPersistentColor(String identifier) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if color is already stored
    final storedColor = prefs.getInt(identifier);

    if (storedColor != null) {
      return Color(storedColor);
    }

    // Generate and store a new color
    final newColor = generateStaticRandomColor(identifier);
    await prefs.setInt(identifier, newColor.value);

    return newColor;
  }

  Future<Color> getCardBackgroundColor(String room) async {
    return await getPersistentColor(room);
  }

  IconData getCardIcon(String room) {
    switch (room) {
      case "Bedroom":
        return CupertinoIcons.bed_double_fill;
      case "Kitchen":
        return Icons.kitchen;
      case "Living Room":
        return CupertinoIcons.tv;
      case "Dining Room":
        return Icons.restaurant_menu;
      case "Office Room":
        return CupertinoIcons.desktopcomputer;
      case "Bathroom":
        return Icons.bathtub;
      case "Laundry Room":
        return Icons.local_laundry_service;
      default:
        return CupertinoIcons.car_detailed;
    }
  }
}

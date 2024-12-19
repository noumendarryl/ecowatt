import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceUtils {
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
        random.nextInt(180) + 50,  // Red (50-230)
        random.nextInt(180) + 50,  // Green (50-230)
        random.nextInt(180) + 50,  // Blue (50-230)
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

  Future<Color> getCardBackgroundColor(String deviceType) async {
    return await getPersistentColor(deviceType);
  }

  IconData getCardIcon(String deviceType) {
    switch (deviceType) {
      case "TVs":
        return CupertinoIcons.tv;
      case "ACs":
        return CupertinoIcons.snow;
      case "Wi-Fi":
        return CupertinoIcons.wifi;
      case "Lamps":
        return CupertinoIcons.lightbulb;
      case "Fridges":
        return Icons.kitchen;
      case "Fans":
        return CupertinoIcons.wind;
      case "Ovens":
        return CupertinoIcons.flame;
      case "Lighting":
        return CupertinoIcons.light_max;
      case "Irons":
        return Icons.iron_outlined;
      case "Printers":
        return CupertinoIcons.printer;
      case "Dryers":
        return Icons.dry_cleaning;
      case "Consoles":
        return CupertinoIcons.game_controller;
      case "Sensors":
        return Icons.sensors;
      case "Monitors":
        return Icons.cast;
      case "Soundbars":
        return CupertinoIcons.hifispeaker;
      case "Air Fryers":
        return Icons.propane_outlined;
      case "Cameras":
        return Icons.camera;
      default:
        return CupertinoIcons.desktopcomputer;
    }
  }
}
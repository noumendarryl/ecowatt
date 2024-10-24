import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceUtils {
  Color getCardBackgroundColor(BuildContext context, String deviceType) {
    switch (deviceType) {
      case "Smart TV":
        return Theme.of(context).colorScheme.primary;
      case "AC":
        return Theme.of(context).colorScheme.secondary;
      case "Wi-Fi":
        return Theme.of(context).colorScheme.secondary;
      case "Lamp":
        return Theme.of(context).colorScheme.scrim;
      case "Fridge":
        return Theme.of(context).colorScheme.onError;
      case "Fan":
        return Theme.of(context).colorScheme.surface;
      case "Washing Machine":
        return Theme.of(context).colorScheme.outlineVariant;
      default:
        return Theme.of(context).colorScheme.tertiary;
    }
  }

  IconData getCardIcon(String deviceType) {
    switch (deviceType) {
      case "Smart TV":
        return CupertinoIcons.tv;
      case "AC":
        return CupertinoIcons.wind_snow;
      case "Wi-Fi":
        return CupertinoIcons.wifi;
      case "Lamp":
        return CupertinoIcons.lightbulb;
      case "Fridge":
        return CupertinoIcons.snow;
      case "Fan":
        return CupertinoIcons.wind;
      case "Washing Machine":
        return Icons.local_laundry_service;
      default:
        return CupertinoIcons.desktopcomputer;
    }
  }
}
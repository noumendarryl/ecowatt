import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  required SnackbarType type,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: _getSnackbarColor(type),
    colorText: Colors.white,
    icon: _getSnackbarIcon(type),
    duration: const Duration(seconds: 5),
    margin: const EdgeInsets.all(15.0),
    borderRadius: 8.0,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  );
}

enum SnackbarType { success, error, info }

Color _getSnackbarColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return Colors.green;
    case SnackbarType.error:
      return Colors.red;
    case SnackbarType.info:
      return Colors.blue;
  }
}

Widget _getSnackbarIcon(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return const Icon(Icons.check_circle, color: Colors.white, size: 25.0,);
    case SnackbarType.error:
      return const Icon(Icons.error, color: Colors.white, size: 25.0,);
    case SnackbarType.info:
      return const Icon(Icons.info, color: Colors.white, size: 25.0,);
  }
}
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SnackbarType { success, error, info, warning }

void showCustomSnackbar(
  BuildContext context, {
  required String title,
  required String message,
  SnackbarType type = SnackbarType.info,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          _getSnackbarIcon(type),
          horizontalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily:
                        Theme.of(context).textTheme.titleMedium!.fontFamily,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily:
                        Theme.of(context).textTheme.bodySmall!.fontFamily,
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: _getSnackbarColor(type),
      duration: duration ?? const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10
        // bottom: MediaQuery.of(context).size.height - 150
      ),
    ),
  );
}

Color _getSnackbarColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return Colors.green.shade600;
    case SnackbarType.error:
      return Colors.red.shade600;
    case SnackbarType.info:
      return Colors.blue.shade600;
    case SnackbarType.warning:
      return Colors.orange.shade600;
  }
}

Widget _getSnackbarIcon(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return const Icon(
        CupertinoIcons.checkmark_seal_fill,
        color: Colors.white,
        size: mediumSize,
      );
    case SnackbarType.error:
      return const Icon(
        CupertinoIcons.exclamationmark_octagon_fill,
        color: Colors.white,
        size: mediumSize,
      );
    case SnackbarType.info:
      return const Icon(
        CupertinoIcons.info_circle_fill,
        color: Colors.white,
        size: mediumSize,
      );
    case SnackbarType.warning:
      return const Icon(
        CupertinoIcons.exclamationmark_triangle_fill,
        color: Colors.white,
        size: mediumSize,
      );
  }
}

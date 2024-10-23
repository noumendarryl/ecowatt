import 'package:ecowatt/features/device/models/device_model.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceCard extends StatefulWidget {
  final DeviceModel device;

  const DeviceCard({
    super.key,
    required this.device,
  });

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: DeviceUtils().getCardBackgroundColor(context, widget.device.type),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Device Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  DeviceUtils().getCardIcon(widget.device.type),
                  size: mediumSize,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                // Toggle Switch
                Switch(
                  value: widget.device.isActive,
                  onChanged: (newValue) async {
                    setState(() {
                      widget.device.isActive = newValue;
                    });
                    await FirebaseFirestore.instance
                        .collection(
                        'devices') // Ensure this is your Firestore collection name
                        .doc(widget.device.did)
                        .update({'isActive': newValue});
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Theme.of(context).colorScheme.onTertiary,
                ),
                // Text(
                //   device.isSmartDevice ? "SMART" : "",
                //   style: TextStyle(
                //     color: Theme.of(context).colorScheme.onSurface,
                //     fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                //   ),
                // ),
              ],
            ),
            verticalSpaceMedium,
            // Device Information
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Text(
                  widget.device.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  // softWrap: true,
                ),
                verticalSpaceSmall,
                Text(
                  widget.device.isActive ? "ON" : "OFF",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

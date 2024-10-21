import 'package:auto_route/annotations.dart';
import 'package:ecowatt/features/device/models/device_model.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class DeviceDetailsScreen extends StatelessWidget {
  final DeviceModel deviceModel;

  const DeviceDetailsScreen({super.key, required this.deviceModel});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceMeasurementModel {
  final String? mid; // / Intensity in Amperes
  final double voltage; // Voltage in Volts
  final double power; // Power in Watts
  final DateTime timestamp; // Time of measurement

  DeviceMeasurementModel({
    this.mid,
    required this.voltage,
    required this.power,
    required this.timestamp,
  });

  // Convert from JSON
  factory DeviceMeasurementModel.fromJson(Map<String, dynamic> data) {
    return DeviceMeasurementModel(
      mid: data['mid'],
      voltage: data['voltage'],
      power: data['power'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Convert to JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'mid': mid,
  //     'voltage': voltage,
  //     'power': power,
  //     'timestamp': timestamp.toIso8601String(),
  //   };
  // }
}

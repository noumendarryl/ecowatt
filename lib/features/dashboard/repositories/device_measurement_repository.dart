import 'package:cloud_firestore/cloud_firestore.dart';

import '../../device/models/device_model.dart';
import '../models/device_measurement_model.dart';

class DeviceMeasurementRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DeviceMeasurementModel>> fetchDeviceMeasurements(
      String userId) async {
    List<DeviceMeasurementModel> measurements = [];

    try {
      // 1. First get all devices for the user
      final devicesSnapshot = await _firestore
          .collection('devices')
          .where('uid', isEqualTo: userId)
          .get();

      if (devicesSnapshot.docs.isEmpty) {
        print('No devices found for user $userId');
        return measurements;
      }

      // 2. For each device, get its measurements from the corresponding sensor
      for (var deviceDoc in devicesSnapshot.docs) {
        try {
          // Convert to DeviceModel to easily access the sid
          final device = DeviceModel.fromJson(deviceDoc.data());

          // Skip if device has no sensor assigned
          if (device.sid == null || device.sid!.isEmpty) {
            print('Device ${device.did} has no sensor assigned');
            continue;
          }

          // Get measurements from the sensor's measurements subcollection
          final measurementsSnapshot = await _firestore
              .collection('sensors')
              .doc(device.sid)
              .collection('measurements')
              .orderBy('timestamp', descending: false)
              .limit(50)
              .get();

          if (measurementsSnapshot.docs.isEmpty) {
            print('No measurements found for sensor ${device.sid}');
            continue;
          }

          // Process each measurement
          for (var measurementDoc in measurementsSnapshot.docs) {
            final data = measurementDoc.data();

            // Verify required fields
            if (data.containsKey('mid') &&
                data.containsKey('power') &&
                data.containsKey('timestamp')) {
              measurements.add(DeviceMeasurementModel(
                mid: data['mid'] ?? measurementDoc.id,
                sid: data['sid'] ?? '',
                power: (data['power'] is int)
                    ? (data['power'] as int).toDouble()
                    : (data['power'] as double? ?? 0.0),
                timestamp: (data['timestamp'] is Timestamp)
                    ? (data['timestamp'] as Timestamp).toDate()
                    : DateTime.now(),
              ));
            }
          }
        } catch (e) {
          print('Error fetching measurements for device ${deviceDoc.id}: $e');
          continue; // Continue with next device if there's an error
        }
      }

      // Sort all measurements by timestamp
      measurements.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      return measurements;
    } catch (e) {
      print('Error in fetchDeviceMeasurements: $e');
      return measurements;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/device_measurement_model.dart';

class DeviceMeasurementRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all measurements for a specific device
  Future<List<DeviceMeasurementModel>> getDeviceMeasurements(String did) async {
    final snapshot = await _firestore
        .collection('measurements')
        .doc(did)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data();
      final measurements = (data?['measurements'] as List<dynamic>)
          .map((measurement) => DeviceMeasurementModel.fromJson(measurement))
          .toList();
      return measurements;
    } else {
      return [];
    }
  }

  // Add a new measurement for a device
  // Future<void> addDeviceMeasurement(DeviceMeasurementModel measurement) async {
  //   final deviceDoc = _firestore.collection('measurements').doc(measurement.mid);
  //   await deviceDoc.set({
  //     'measurements': FieldValue.arrayUnion([measurement.toJson()]),
  //   }, SetOptions(merge: true)); // Merge to avoid overwriting existing data
  // }
}

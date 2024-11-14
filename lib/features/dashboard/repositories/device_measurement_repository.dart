import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/device_measurement_model.dart';

class DeviceMeasurementRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DeviceMeasurementModel>> fetchDeviceMeasurement(String userId) async {
    List<DeviceMeasurementModel> measurements = [];

    // Récupérer tous les équipements
    final devices= await _firestore.collection('devices').where('uid', isEqualTo: userId) // Filtrer par user_id
        .get();

    for (var device in devices.docs) {
      // Pour chaque équipement, récupérer les données électriques
      final dataSnapshot = await device.reference.collection('measurements').get();

      // Convertir les données en modèles
      for (var dataDoc in dataSnapshot.docs) {
        final data = dataDoc.data();
        measurements.add(DeviceMeasurementModel(
          mid: device.id,
          voltage: data['voltage'],
          power: data['power'],
          timestamp: (data['timestamp'] as Timestamp).toDate(),
        ));
      }
    }

    return measurements;
  }
}
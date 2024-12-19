import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sensor_model.dart';

class SensorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SensorModel>> getAllSensors() async {
    try {
      final snapshot = await _firestore.collection('sensors').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return SensorModel(
          sid: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error in getAllSensors: $e');
      return [];
    }
  }

  Future<SensorModel?> getSensorById(String sensorId) async {
    try {
      final doc = await _firestore.collection('sensors').doc(sensorId).get();

      if (!doc.exists) {
        print('No sensor found with ID : $sensorId');
        return null;
      }

      final data = doc.data()!;
      return SensorModel(
        sid: doc.id,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
      );
    } catch (e) {
      print('Error in getSensorById : $e');
      return null;
    }
  }
}

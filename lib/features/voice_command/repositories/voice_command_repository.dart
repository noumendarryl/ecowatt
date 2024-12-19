import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowatt/features/device/models/device_model.dart';

import '../models/voice_command_model.dart';

class VoiceCommandRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DeviceModel?> processVoiceCommand(VoiceCommandModel command) async {
    try {
      // Query devices based on device type
      QuerySnapshot deviceSnapshot = await _firestore
          .collection('devices')
          .where('name', isEqualTo: command.deviceName)
          .limit(1)
          .get();

      if (deviceSnapshot.docs.isEmpty) {
        return null;
      }

      // Get the first matching device
      DocumentSnapshot deviceDoc = deviceSnapshot.docs.first;
      DeviceModel device = DeviceModel.fromJson(
        deviceDoc.data() as Map<String, dynamic>,
      );

      // Update device state
      await _firestore
          .collection('devices')
          .doc(device.did)
          .update({'isActive': command.isActive});

      // Return updated device
      return device.copyWith(isActive: command.isActive);
    } catch (e) {
      print('Error processing voice command: $e');
      return null;
    }
  }

  Stream<List<DeviceModel>> getAllDevices() {
    return _firestore.collection('devices').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => DeviceModel.fromJson(doc.data())).toList());
  }
}

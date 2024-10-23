import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/device_model.dart';

class DeviceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all devices
  Future<List<DeviceModel>> getAllDevices() async {
    final snapshot = await _firestore.collection('devices').get();

    return snapshot.docs
        .map((doc) => DeviceModel.fromJson(doc.data()))
        .toList();
  }

  // Get a single device by ID
  Future<DeviceModel?> getDeviceById(String did) async {
    final doc = await _firestore.collection('devices').doc(did).get();

    if (doc.exists) {
      return DeviceModel.fromJson(doc.data()!);
    } else {
      return null; // Device not found
    }
  }

  // Create a new device
  Future<void> createDevice(DeviceModel device) async {
    DocumentReference deviceRef = FirebaseFirestore.instance
        .collection('devices')
        .doc();

    DeviceModel newDevice = DeviceModel(
        did: deviceRef.id,
        name: device.name,
        description: device.description,
        type: device.type,
        rid: device.rid,
        sensorId: device.sensorId,
        uid: FirebaseAuth.instance.currentUser!.uid,
        isActive: device.isSmartDevice,
        isSmartDevice: device.isSmartDevice);

    await deviceRef // Use device ID as document ID
        .set(newDevice.toJson());

    await deviceRef // Use device ID as document ID
        .collection('measurements')
        .add(newDevice.measurements!);
  }

  // Update an existing device
  Future<void> updateDevice(DeviceModel updatedDevice) async {
    await _firestore
        .collection('devices')
        .doc(updatedDevice.did)
        .update(updatedDevice.toJson());
  }

  // Delete a device by ID
  Future<void> deleteDevice(String did) async {
    await _firestore.collection('devices').doc(did).delete();
  }

  // Get devices by roomId
  Future<List<DeviceModel>> getDevicesByRoomId(String rid) async {
    final snapshot = await _firestore
        .collection('devices')
        .where('rid', isEqualTo: rid)
        .get();

    return snapshot.docs
        .map((doc) => DeviceModel.fromJson(doc.data()))
        .toList();
  }

  // Search devices by name
  Future<List<DeviceModel>> searchDevicesByName(String query) async {
    final snapshot = await _firestore
        .collection('devices')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    return snapshot.docs
        .map((doc) => DeviceModel.fromJson(doc.data()))
        .toList();
  }
}

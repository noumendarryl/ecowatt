import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/room_model.dart';

class RoomRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all rooms
  Future<List<RoomModel>> getAllRooms() async {
    final snapshot = await _firestore.collection('rooms').get();

    return snapshot.docs.map((doc) => RoomModel.fromJson(doc.data())).toList();
  }

  // Get room by ID
  Future<RoomModel?> getRoomById(String rid) async {
    final doc = await _firestore.collection('rooms').doc(rid).get();

    if (doc.exists) {
      return RoomModel.fromJson(doc.data()!);
    } else {
      return null; // Room not found
    }
  }

  // Create a new room
  Future<void> createRoom(RoomModel room) async {
    DocumentReference roomRef = FirebaseFirestore.instance
        .collection('rooms')
        .doc();

    RoomModel newRoom = RoomModel(
        rid: roomRef.id, name: room.name, totalDevices: room.totalDevices);

    await roomRef.set(newRoom.toJson());
  }

  // Update a room
  Future<void> updateRoom(RoomModel updatedRoom) async {
    await _firestore
        .collection('rooms')
        .doc(updatedRoom.rid)
        .update(updatedRoom.toJson());
  }

  // Delete a room by ID
  Future<void> deleteRoom(String rid) async {
    await _firestore.collection('rooms').doc(rid).delete();
  }
}

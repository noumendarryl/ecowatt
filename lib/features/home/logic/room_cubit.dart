import 'package:ecowatt/features/home/logic/room_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../device/models/device_model.dart';
import '../models/room_model.dart';
import '../repositories/room_repository.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepository _roomRepository;

  RoomCubit(this._roomRepository) : super(const RoomInitial());

  // Retrieve all rooms
  Future<void> fetchRooms() async {
    try {
      emit(const RoomLoading());
      final rooms = await _roomRepository.getAllRooms();
      emit(RoomLoaded(rooms));
    } catch (e) {
      emit(const RoomError('Failed to load rooms'));
    }
  }

  // Retrieve a single room by ID (along with its devices)
  Future<void> fetchRoomById(String roomId) async {
    try {
      emit(const RoomLoading());
      final room = await _roomRepository.getRoomById(roomId);
      emit(RoomDetailsLoaded(room!));
    } catch (e) {
      emit(const RoomError('Failed to load room details'));
    }
  }

  // Get the total number of devices for a specific room
  int fetchTotalDevicesByRoom(String roomId, List<DeviceModel> devices) {
    return devices.where((device) => device.rid == roomId).length;
  }

  // Create a new room
  Future<void> createRoom(RoomModel newRoom) async {
    try {
      emit(const RoomLoading());
      await _roomRepository.createRoom(newRoom);
      await fetchRooms(); // Refresh list after creating
    } catch (e) {
      emit(const RoomError('Failed to create room'));
    }
  }

  // Update a room
  Future<void> updateRoom(RoomModel updatedRoom) async {
    try {
      emit(const RoomLoading());
      await _roomRepository.updateRoom(updatedRoom);
      await fetchRooms(); // Refresh list after updating
    } catch (e) {
      emit(const RoomError('Failed to update room'));
    }
  }

  // Delete a room by ID
  Future<void> deleteRoom(String roomId) async {
    try {
      emit(const RoomLoading());
      await _roomRepository.deleteRoom(roomId);
      await fetchRooms(); // Refresh list after deletion
    } catch (e) {
      emit(const RoomError('Failed to delete room'));
    }
  }
}

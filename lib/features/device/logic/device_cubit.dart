import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/device_model.dart';
import '../repositories/device_repository.dart';
import 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  final DeviceRepository _deviceRepository;

  DeviceCubit(this._deviceRepository) : super(const DeviceInitial());

  // Retrieve all devices
  Future<void> fetchAllDevices() async {
    try {
      emit(const DeviceLoading());
      final devices = await _deviceRepository.getAllDevices();
      emit(DeviceLoaded(devices));
    } catch (e) {
      emit(const DeviceError('Failed to load devices'));
    }
  }

  // Retrieve a single device by ID
  Future<void> fetchDeviceById(String did) async {
    try {
      emit(const DeviceLoading());
      final device = await _deviceRepository.getDeviceById(did);
      if (device == null) {
        emit(const DeviceError('Device not found'));
      }
    } catch (e) {
      emit(const DeviceError('Failed to load device details'));
    }
  }

  // Create a new device
  Future<void> createDevice(DeviceModel newDevice) async {
    try {
      emit(const DeviceLoading());

      await _deviceRepository.createDevice(newDevice);
      await fetchAllDevices(); // Refresh devices after adding
    } catch (e) {
      emit(const DeviceError('Failed to create device'));
    }
  }

  // Update an existing device
  Future<void> updateDevice(DeviceModel updatedDevice) async {
    try {
      emit(const DeviceLoading());
      await _deviceRepository.updateDevice(updatedDevice);
      await fetchAllDevices(); // Refresh devices after updating
    } catch (e) {
      emit(const DeviceError('Failed to update device'));
    }
  }

  // Delete a device by ID
  Future<void> deleteDevice(String did) async {
    try {
      emit(const DeviceLoading());
      await _deviceRepository.deleteDevice(did);
      await fetchAllDevices(); // Refresh devices after deletion
    } catch (e) {
      emit(const DeviceError('Failed to delete device'));
    }
  }

  // Get  devices by room ID
  Future<void> fetchDevicesByRoomId(String rid) async {
    try {
      emit(const DeviceLoading());
      final devices = await _deviceRepository.getDevicesByRoomId(rid);
      emit(DeviceLoaded(devices));
    } catch (e) {
      emit(const DeviceError('Failed to load devices for this room'));
    }
  }

  // Search for devices by name
  Future<void> searchDevicesByName(String query) async {
    try {
      emit(const DeviceLoading());
      final devices = await _deviceRepository.searchDevicesByName(query);
      emit(DeviceLoaded(devices));
    } catch (e) {
      emit(const DeviceError('Failed to find this device'));
    }
  }
}

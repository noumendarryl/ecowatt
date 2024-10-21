import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/device_type_repository.dart';
import 'device_type_state.dart';

class DeviceTypeCubit extends Cubit<DeviceTypeState> {
  final DeviceTypeRepository _deviceTypeRepository;

  DeviceTypeCubit(this._deviceTypeRepository) : super(const DeviceTypeInitial());

  // Load device types from the repository
  Future<void> loadDeviceTypes() async {
    emit(const DeviceTypeLoading());

    try {
      final deviceTypes = await _deviceTypeRepository.getDeviceTypes(); // Can be from Firebase or locally
      emit(DeviceTypeLoaded(deviceTypes));
    } catch (e) {
      emit(const DeviceTypeError("Failed to load device types."));
    }
  }
}

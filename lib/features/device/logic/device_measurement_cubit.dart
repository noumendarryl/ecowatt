import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/device_measurement_repository.dart';
import 'device_measurement_state.dart';

class DeviceMeasurementCubit extends Cubit<DeviceMeasurementState> {
  final DeviceMeasurementRepository deviceMeasurementRepository;

  DeviceMeasurementCubit(this.deviceMeasurementRepository) : super(const DeviceMeasurementInitial());

  // Retrieve measurements for a specific device
  Future<void> fetchDeviceMeasurements(String mid, String did) async {
    try {
      emit(const DeviceMeasurementLoading());
      final measurements = await deviceMeasurementRepository.getDeviceMeasurements(mid, did);
      emit(DeviceMeasurementsLoaded(measurements));
    } catch (e) {
      emit(const DeviceMeasurementError('Failed to load device measurements.'));
    }
  }
}

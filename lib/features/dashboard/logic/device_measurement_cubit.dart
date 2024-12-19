import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../repositories/device_measurement_repository.dart';

import 'device_measurement_state.dart';

class DeviceMeasurementCubit extends Cubit<DeviceMeasurementState> {
  final DeviceMeasurementRepository _repository;

  DeviceMeasurementCubit(this._repository) : super(const DeviceMeasurementState.initial());

  Future<void> loadDeviceMeasurements(String userId) async {
    try {
      // Emit loading state
      emit(const DeviceMeasurementState.loading());

      // Debug: Print user ID
      debugPrint('Loading measurements for user ID: $userId');

      // Fetch measurements
      final data = await _repository.fetchDeviceMeasurements(userId);

      // Debug: Print measurements count
      debugPrint('Measurements collected: ${data.length}');

      // Handle empty measurements
      if (data.isEmpty) {
        debugPrint('No measurements found');
        emit(const DeviceMeasurementState.error(
          'No electricity data found. Check device connections and measurements.'
        ));
        return;
      }

      // Emit loaded state
      emit(DeviceMeasurementState.loaded(data));
    } catch (e) {
      // Debug: Print any critical errors
      debugPrint('Critical error in loadDeviceMeasurements: $e');

      // Emit error state
      emit(DeviceMeasurementState.error(
        'Failed to load electricity data. Error: ${e.toString()}'
      ));
    }
  }
}

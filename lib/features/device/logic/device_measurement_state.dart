import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/device_measurement_model.dart';

part 'device_measurement_state.freezed.dart';

@freezed
class DeviceMeasurementState with _$DeviceMeasurementState {
  const factory DeviceMeasurementState.initial() = DeviceMeasurementInitial;
  const factory DeviceMeasurementState.loading() = DeviceMeasurementLoading;
  const factory DeviceMeasurementState.loaded(List<DeviceMeasurementModel> measurements) = DeviceMeasurementsLoaded;
  const factory DeviceMeasurementState.error(String message) = DeviceMeasurementError;
}

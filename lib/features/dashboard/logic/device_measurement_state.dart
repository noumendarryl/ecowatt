import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/device_measurement_model.dart';

part 'device_measurement_state.freezed.dart';

@freezed
class DeviceMeasurementState with _$DeviceMeasurementState {
  const factory DeviceMeasurementState.initial() = _Initial;
  const factory DeviceMeasurementState.loading() = _Loading;
  const factory DeviceMeasurementState.loaded(List<DeviceMeasurementModel> data) = _Loaded;
  const factory DeviceMeasurementState.error(String message) = _Error;
}
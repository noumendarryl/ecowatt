import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/device_model.dart';

part 'device_state.freezed.dart';

@freezed
class DeviceState with _$DeviceState {
  const factory DeviceState.initial() = DeviceInitial;
  const factory DeviceState.loading() = DeviceLoading;
  const factory DeviceState.loaded(List<DeviceModel> devices) = DeviceLoaded;
  const factory DeviceState.error(String message) = DeviceError;
}

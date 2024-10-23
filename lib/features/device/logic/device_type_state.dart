import 'package:ecowatt/features/device/models/device_type_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_type_state.freezed.dart';

@freezed
class DeviceTypeState with _$DeviceTypeState {
  const factory DeviceTypeState.initial() = DeviceTypeInitial;
  const factory DeviceTypeState.loading() = DeviceTypeLoading;
  const factory DeviceTypeState.loaded(List<DeviceTypeModel> deviceTypes) = DeviceTypeLoaded;
  const factory DeviceTypeState.error(String message) = DeviceTypeError;
}

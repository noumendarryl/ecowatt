import 'package:freezed_annotation/freezed_annotation.dart';
import '../../device/models/device_model.dart';
import '../models/voice_command_model.dart';

part 'voice_command_state.freezed.dart';

@freezed
class VoiceCommandState with _$VoiceCommandState {
  const factory VoiceCommandState.initial() = _Initial;
  const factory VoiceCommandState.listening() = _Listening;
  const factory VoiceCommandState.processing(VoiceCommandModel command) = _Processing;
  const factory VoiceCommandState.success(DeviceModel device) = _Success;
  const factory VoiceCommandState.error(String message) = _Error;
}

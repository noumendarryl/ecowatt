import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_command_model.freezed.dart';
part 'voice_command_model.g.dart';

@freezed
class VoiceCommandModel with _$VoiceCommandModel {
  const factory VoiceCommandModel({
    required String command,
    required String deviceName,
    required bool isActive,
  }) = _VoiceCommandModel;

  factory VoiceCommandModel.fromJson(Map<String, dynamic> json)
  => _$VoiceCommandModelFromJson(json);
}
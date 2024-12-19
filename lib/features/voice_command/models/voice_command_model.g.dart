// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoiceCommandModelImpl _$$VoiceCommandModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VoiceCommandModelImpl(
      command: json['command'] as String,
      deviceName: json['deviceName'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$$VoiceCommandModelImplToJson(
        _$VoiceCommandModelImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'deviceName': instance.deviceName,
      'isActive': instance.isActive,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceMeasurementModelImpl _$$DeviceMeasurementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeviceMeasurementModelImpl(
      mid: json['mid'] as String,
      sid: json['sid'] as String,
      power: (json['power'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DeviceMeasurementModelImplToJson(
        _$DeviceMeasurementModelImpl instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'sid': instance.sid,
      'power': instance.power,
      'timestamp': instance.timestamp.toIso8601String(),
    };

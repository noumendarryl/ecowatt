// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherModelImpl _$$WeatherModelImplFromJson(Map<String, dynamic> json) =>
    _$WeatherModelImpl(
      cityName: json['cityName'] as String,
      icon: json['icon'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$WeatherModelImplToJson(_$WeatherModelImpl instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'icon': instance.icon,
      'temperature': instance.temperature,
      'description': instance.description,
    };

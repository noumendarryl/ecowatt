// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_command_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoiceCommandModel _$VoiceCommandModelFromJson(Map<String, dynamic> json) {
  return _VoiceCommandModel.fromJson(json);
}

/// @nodoc
mixin _$VoiceCommandModel {
  String get command => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this VoiceCommandModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoiceCommandModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoiceCommandModelCopyWith<VoiceCommandModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceCommandModelCopyWith<$Res> {
  factory $VoiceCommandModelCopyWith(
          VoiceCommandModel value, $Res Function(VoiceCommandModel) then) =
      _$VoiceCommandModelCopyWithImpl<$Res, VoiceCommandModel>;
  @useResult
  $Res call({String command, String deviceName, bool isActive});
}

/// @nodoc
class _$VoiceCommandModelCopyWithImpl<$Res, $Val extends VoiceCommandModel>
    implements $VoiceCommandModelCopyWith<$Res> {
  _$VoiceCommandModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoiceCommandModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? deviceName = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoiceCommandModelImplCopyWith<$Res>
    implements $VoiceCommandModelCopyWith<$Res> {
  factory _$$VoiceCommandModelImplCopyWith(_$VoiceCommandModelImpl value,
          $Res Function(_$VoiceCommandModelImpl) then) =
      __$$VoiceCommandModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String command, String deviceName, bool isActive});
}

/// @nodoc
class __$$VoiceCommandModelImplCopyWithImpl<$Res>
    extends _$VoiceCommandModelCopyWithImpl<$Res, _$VoiceCommandModelImpl>
    implements _$$VoiceCommandModelImplCopyWith<$Res> {
  __$$VoiceCommandModelImplCopyWithImpl(_$VoiceCommandModelImpl _value,
      $Res Function(_$VoiceCommandModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceCommandModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? deviceName = null,
    Object? isActive = null,
  }) {
    return _then(_$VoiceCommandModelImpl(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoiceCommandModelImpl implements _VoiceCommandModel {
  const _$VoiceCommandModelImpl(
      {required this.command,
      required this.deviceName,
      required this.isActive});

  factory _$VoiceCommandModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoiceCommandModelImplFromJson(json);

  @override
  final String command;
  @override
  final String deviceName;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'VoiceCommandModel(command: $command, deviceName: $deviceName, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceCommandModelImpl &&
            (identical(other.command, command) || other.command == command) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, command, deviceName, isActive);

  /// Create a copy of VoiceCommandModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceCommandModelImplCopyWith<_$VoiceCommandModelImpl> get copyWith =>
      __$$VoiceCommandModelImplCopyWithImpl<_$VoiceCommandModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoiceCommandModelImplToJson(
      this,
    );
  }
}

abstract class _VoiceCommandModel implements VoiceCommandModel {
  const factory _VoiceCommandModel(
      {required final String command,
      required final String deviceName,
      required final bool isActive}) = _$VoiceCommandModelImpl;

  factory _VoiceCommandModel.fromJson(Map<String, dynamic> json) =
      _$VoiceCommandModelImpl.fromJson;

  @override
  String get command;
  @override
  String get deviceName;
  @override
  bool get isActive;

  /// Create a copy of VoiceCommandModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoiceCommandModelImplCopyWith<_$VoiceCommandModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

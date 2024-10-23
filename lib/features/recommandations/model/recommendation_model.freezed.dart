// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecommendationModel _$RecommendationModelFromJson(Map<String, dynamic> json) {
  return _RecommendationModel.fromJson(json);
}

/// @nodoc
mixin _$RecommendationModel {
  String get titre => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this RecommendationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationModelCopyWith<RecommendationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationModelCopyWith<$Res> {
  factory $RecommendationModelCopyWith(
          RecommendationModel value, $Res Function(RecommendationModel) then) =
      _$RecommendationModelCopyWithImpl<$Res, RecommendationModel>;
  @useResult
  $Res call({String titre, String description});
}

/// @nodoc
class _$RecommendationModelCopyWithImpl<$Res, $Val extends RecommendationModel>
    implements $RecommendationModelCopyWith<$Res> {
  _$RecommendationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titre = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      titre: null == titre
          ? _value.titre
          : titre // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendationModelImplCopyWith<$Res>
    implements $RecommendationModelCopyWith<$Res> {
  factory _$$RecommendationModelImplCopyWith(_$RecommendationModelImpl value,
          $Res Function(_$RecommendationModelImpl) then) =
      __$$RecommendationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String titre, String description});
}

/// @nodoc
class __$$RecommendationModelImplCopyWithImpl<$Res>
    extends _$RecommendationModelCopyWithImpl<$Res, _$RecommendationModelImpl>
    implements _$$RecommendationModelImplCopyWith<$Res> {
  __$$RecommendationModelImplCopyWithImpl(_$RecommendationModelImpl _value,
      $Res Function(_$RecommendationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titre = null,
    Object? description = null,
  }) {
    return _then(_$RecommendationModelImpl(
      titre: null == titre
          ? _value.titre
          : titre // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendationModelImpl implements _RecommendationModel {
  const _$RecommendationModelImpl(
      {required this.titre, required this.description});

  factory _$RecommendationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendationModelImplFromJson(json);

  @override
  final String titre;
  @override
  final String description;

  @override
  String toString() {
    return 'RecommendationModel(titre: $titre, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationModelImpl &&
            (identical(other.titre, titre) || other.titre == titre) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, titre, description);

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationModelImplCopyWith<_$RecommendationModelImpl> get copyWith =>
      __$$RecommendationModelImplCopyWithImpl<_$RecommendationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendationModelImplToJson(
      this,
    );
  }
}

abstract class _RecommendationModel implements RecommendationModel {
  const factory _RecommendationModel(
      {required final String titre,
      required final String description}) = _$RecommendationModelImpl;

  factory _RecommendationModel.fromJson(Map<String, dynamic> json) =
      _$RecommendationModelImpl.fromJson;

  @override
  String get titre;
  @override
  String get description;

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationModelImplCopyWith<_$RecommendationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

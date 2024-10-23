import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/recommendation_model.dart';


part 'recommendation_state.freezed.dart';


@freezed
class RecommendationState with _$RecommendationState {
  const factory RecommendationState.initial() = _Initial;
  const factory RecommendationState.loading() = _Loading;
  const factory RecommendationState.loaded(List<RecommendationModel> recommendations) = _Loaded;
  const factory RecommendationState.error(String message) = _Error;
}
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/recommendation_repository.dart';
import 'recommendation_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  final RecommendationRepository _repository;

  RecommendationCubit(this._repository)
      : super(const RecommendationState.initial());

  Future<void> loadRecommendations() async {
    try {
      emit(const RecommendationState.loading());
      final recommendations = await _repository.fetchRecommendations();
      emit(RecommendationState.loaded(recommendations));
    } catch (e) {
      emit(RecommendationState.error(e.toString()));
    }
  }
}

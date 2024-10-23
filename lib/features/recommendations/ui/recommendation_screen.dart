import 'package:auto_route/annotations.dart';
import 'package:ecowatt/shared/widgets/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/recommendation_cubit.dart';
import '../logic/recommendation_state.dart';
import '../repositories/recommendation_repository.dart';

@RoutePage()
class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Recommendations',
      currentIndex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
        ),
        child: BlocProvider(
          create: (context) => RecommendationCubit(RecommendationRepository())
            ..loadRecommendations(),
          child: BlocBuilder<RecommendationCubit, RecommendationState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: Text('Initial State')),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (recommendations) => ListView.builder(
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) {
                    final recommendation = recommendations[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // Arrondi des coins
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          tileColor: Theme.of(context).colorScheme.primary,
                          textColor: Colors.white,
                          title: Text(
                            recommendation.titre,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          subtitle: Text(recommendation.description),
                        ),
                      ),
                    );
                  },
                ),
                error: (message) => Center(child: Text('Erreur : $message')),
              );
            },
          ),
        ),
      ),
    );
  }
}

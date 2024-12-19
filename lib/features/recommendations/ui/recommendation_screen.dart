import 'package:auto_route/annotations.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/widgets/base_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/recommendation_cubit.dart';
import '../logic/recommendation_state.dart';
import '../models/recommendation_model.dart';
import '../repositories/recommendation_repository.dart';

@RoutePage()
class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  // Current selected category
  String _activeCategory = 'efficiency';
  List<RecommendationModel> _recommendations = [];

  @override
  void initState() {
    super.initState();
    _fetchRecommendations();
  }

  Future<void> _fetchRecommendations() async {
    RecommendationRepository recommendationsRepo = RecommendationRepository();
    final recommendations = await recommendationsRepo.fetchRecommendations();
    setState(() {
      _recommendations = recommendations;
      // Set initial category to the first category found
      if (_recommendations.isNotEmpty) {
        _activeCategory = _recommendations.first.category;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter recommendations for the active category
    final currentCategoryRecommendations = _recommendations
        .where((recommendation) => recommendation.category == _activeCategory)
        .toList();

    return BaseLayout(
      title: 'Recommendations',
      currentIndex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        child: BlocProvider(
          create: (context) => RecommendationCubit(RecommendationRepository())
            ..loadRecommendations(),
          child: BlocBuilder<RecommendationCubit, RecommendationState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: Text('')),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (recommendations) => SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(smallSize + 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Category Selector
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  _getUniqueCategoriesFromRecommendations()
                                      .map((category) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: tinySize),
                                  child: ChoiceChip(
                                    label: Text(
                                      _capitalizeFirstLetter(
                                          category.toString().split('.').last),
                                      style: TextStyle(
                                        color: _activeCategory == category
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                            : Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                      ),
                                    ),
                                    checkmarkColor:
                                        Theme.of(context).colorScheme.onSurface,
                                    selected: _activeCategory == category,
                                    onSelected: (_) {
                                      setState(() {
                                        _activeCategory = category;
                                      });
                                    },
                                    selectedColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onTertiary,
                                    side: _activeCategory == category
                                        ? BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            width: 1.0)
                                        : BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            width: 1.0),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          verticalSpaceSmall,

                          // Recommendation Card
                          if (currentCategoryRecommendations.isNotEmpty)
                            _buildRecommendationCard(
                                currentCategoryRecommendations.first),

                          // Global Impact Message
                          verticalSpaceMedium,
                          Text(
                              'Let\'s fight together to preserve our planet\'s future \n cause we only got one',
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .fontFamily,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .fontSize,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ),
                error: (message) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: smallSize),
                      child: Text(
                        message,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .fontSize),
                        textAlign: TextAlign.center,
                      ),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(RecommendationModel recommendation) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(smallSize),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(smallSize),
            decoration: const BoxDecoration(
              color: Color(0xFFEEE5FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(smallSize),
                topRight: Radius.circular(smallSize),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  recommendation.icon,
                  color: const Color(0xFFB395FF),
                  size: smallSize + 10,
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recommendation.title,
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        recommendation.impact,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelSmall!.fontSize,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(smallSize),
                bottomRight: Radius.circular(smallSize),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(smallSize),
              child: Column(
                children: recommendation.tips
                    .map((tip) => _buildTipRow(tip))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipRow(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: smallSize),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.checkmark_seal,
            size: smallSize + 10,
            color: Theme.of(context).colorScheme.primary,
          ),
          horizontalSpaceSmall,
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to get unique categories from recommendations
  List<String> _getUniqueCategoriesFromRecommendations() {
    return _recommendations
        .map((recommendation) => recommendation.category)
        .toSet()
        .toList();
  }

  // Utility method to capitalize first letter
  String _capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
